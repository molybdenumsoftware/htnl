{ lib }:
let
  spec = import ./spec.nix { inherit lib; };

  isVoidTag = tn: spec.elements.${tn}.void or false;

  toDocument = content: {
    _type = "document";
    inherit content;
  };

  # These return an arbitrarily nested list of string
  serializers = {
    document = ir: [
      "<!DOCTYPE html>"
      (serializers.elem ir.content)
    ];

    elem = ir: [
      "<"
      ir.tn
      (lib.optionals (ir.attrs != { }) [
        " "
        (serializers.attrs ir.attrs)
      ])
      ">"
      (lib.optionals (!isVoidTag ir.tn) [
        (serializers.fragment ir.children)
        "</"
        ir.tn
        ">"
      ])
    ];

    attr = name: value: [
      name
      (lib.optionals (lib.isString value || lib.isDerivation value) [
        ''="''
        (value |> toString |> lib.escapeXML)
        ''"''
      ])
    ];

    attrs = attrs: attrs |> lib.mapAttrsToList serializers.attr |> lib.intersperse " ";

    text = lib.escapeXML;

    fragment = map serializers.unknown;

    # no escaping
    raw = ir: ir.content;

    unknown =
      ir:
      let
        type = lib.typeOf ir;
      in
      if type == "string" then
        lib.escapeXML ir
      else if type == "list" then
        serializers.fragment ir
      else if type == "set" then
        if ir._type or null == "document" then
          serializers.document ir
        else if ir._type or null == "elem" then
          serializers.elem ir
        else if ir._type or null == "raw" then
          serializers.raw ir
        else
          serializers.attrs ir
      else
        throw "cannot serialize value (type: ${type})";
  };

  # Validity is indicated by subject value being returned successfully
  validators = {
    tagName =
      tn:
      assert lib.isString tn;
      assert lib.match "[0-9a-zA-Z]+" tn == [ ];
      tn;

    attributes =
      tn: attrs:
      assert lib.isAttrs attrs;
      validators.attribute tn |> lib.flip lib.mapAttrs attrs;

    attribute =
      tn: name: value:
      let
        facts = spec.elements.${tn}.attributes.${name} or null;
      in
      assert lib.assertMsg (facts != null) "fattribute ${name} not allowed on tag ${tn}";
      if facts.boolean or false then
        assert lib.assertMsg value "non-true value for boolean attribute `${name}` of tag `${tn}`";
        value
      else if lib.isDerivation value then
        value
      else
        assert lib.assertMsg (lib.isString value) "non-string attribute value";
        value;

    children = tn: map (validators.child tn);

    child =
      tn: arg:
      assert lib.assertMsg (
        lib.isString arg
        || lib.elem arg._type or null [
          "elem"
          "raw"
        ]
        || lib.isDerivation arg
      ) "invalid child";
      arg;
  };

  ctors = {
    raw =
      content:
      assert lib.assertMsg (lib.isString content) "raw called with non-string";
      {
        _type = "raw";
        inherit content;
      };
    monomorphic =
      tn_: attrs_: children_:
      let
        tn = validators.tagName tn_;
        attrs = validators.attributes tn attrs_;
        children = validators.children tn children_;
      in
      {
        _type = "elem";
        inherit tn attrs children;
      };

    polymorphic =
      tn:
      let
        partial = ctors.monomorphic tn;
        isVoid = isVoidTag tn;
      in
      argB:
      let
        argBType = lib.typeOf argB;
      in
      if
        lib.elem argBType [
          "string"
          "list"
        ]
        || lib.elem argB._type or null [
          "elem"
          "raw"
        ]
      then
        argB |> lib.toList |> partial { }
      else if argBType == "set" then
        if isVoid then
          partial argB [ ]
          // {
            __functor = _: _: throw "attempt to pass children to void element ${tn}";
          }
        else
          children: children |> lib.toList |> partial argB
      else
        throw "not supported";
  };

  serialize = ir: serializers.unknown ir |> lib.flatten |> lib.concatStrings;

  bundle =
    pkgs:
    {
      name ? "htnl-bundle",
      # FIXME support receiving basePath
      htmlDocuments,
    }:
    htmlDocuments
    |>
      lib.foldlAttrs
        (
          acc: htmlDocumentPath: htmlDocument:
          let
            htmlString = serialize htmlDocument;

            documentAssetLines =
              htmlString
              |> builtins.getContext
              |> lib.mapAttrs (
                drvPath: _:
                ''cp -r ${
                  # This returns the `outPath` of the *.drv
                  import drvPath
                } "$out/nix/store"''
              );
          in
          {
            htmlFileLines = lib.concat acc.htmlFileLines [
              ''mkdir -p "$out/${builtins.dirOf htmlDocumentPath}"''
              ''echo -n ${lib.escapeShellArg htmlString} > "$out/${htmlDocumentPath}"''
            ];

            assetLines = acc.assetLines // documentAssetLines;
          }
        )
        {
          htmlFileLines = [ ];
          assetLines = { };
        }
    |> (
      { htmlFileLines, assetLines }:
      [
        htmlFileLines
        ''mkdir -p "$out"'' # support empty bundles
        (lib.optionalString (assetLines != { }) ''mkdir -p "$out/nix/store"'')
        (lib.attrValues assetLines)
      ]
    )
    |> lib.flatten
    |> lib.concatLines
    |> pkgs.runCommand name { };
in
# public API
{
  inherit serialize toDocument bundle;
  inherit (ctors) raw;
  polymorphic = {
    element = ctors.polymorphic;
    partials = spec.elements |> lib.mapAttrs (name: value: ctors.polymorphic name);
  };
  # Maybe add these in the future, in case users want more performance
  # and it turns out these perform significantly better...
  # monomorphic = {
  #   element = ctors.monomorphic;
  #   partials = {
  #     #a p html body
  #   };
  # };
}
