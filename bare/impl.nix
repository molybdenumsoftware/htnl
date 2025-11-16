{ lib }:
let
  constants = {
    raw = "htnl-raw";
    element = "htnl-element";
    document = "htnl-document";
  };

  spec = import ./spec.nix { inherit lib; };

  isVoidTag = tagName: spec.elements.${tagName}.void or false;

  document = content: {
    type = constants.document;
    inherit content;
  };

  # These return an arbitrarily nested list of string
  serializers = {
    document = ir: [
      "<!DOCTYPE html>"
      (serializers.element ir.content)
    ];

    element = ir: [
      "<"
      ir.tagName
      (lib.optionals (ir.attributes != { }) [
        " "
        (serializers.attributes ir.attributes)
      ])
      ">"
      (lib.optionals (!isVoidTag ir.tagName) [
        (serializers.fragment ir.children)
        "</"
        ir.tagName
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

    attributes = attributes: attributes |> lib.mapAttrsToList serializers.attr |> lib.intersperse " ";

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
        if ir.type or null == constants.document then
          serializers.document ir
        else if ir.type or null == constants.element then
          serializers.element ir
        else if ir.type or null == constants.raw then
          serializers.raw ir
        else
          serializers.attributes ir
      else
        throw "cannot serialize value (type: ${type})";
  };

  # Validity is indicated by subject value being returned successfully
  validators = {
    tagName =
      tagName:
      assert lib.isString tagName;
      assert lib.match "[0-9a-zA-Z]+" tagName == [ ];
      tagName;

    attributes =
      tagName: attributes:
      assert lib.isAttrs attributes;
      validators.attribute tagName |> lib.flip lib.mapAttrs attributes;

    attribute =
      tagName: name: value:
      let
        facts = spec.elements.${tagName}.attributes.${name} or null;
      in
      assert lib.assertMsg (facts != null) "fattribute ${name} not allowed on tag ${tagName}";
      if facts.boolean or false then
        assert lib.assertMsg value "non-true value for boolean attribute `${name}` of tag `${tagName}`";
        value
      else if lib.isDerivation value then
        value
      else
        assert lib.assertMsg (lib.isString value) "non-string attribute value";
        value;

    children = tagName: map (validators.child tagName);

    child =
      tagName: arg:
      if lib.isList arg then
        validators.children tagName arg
      else
        assert lib.assertMsg (
          lib.isString arg
          || lib.elem arg.type or null [
            constants.element
            constants.raw
          ]
          || lib.isDerivation arg
        ) (lib.trace arg "invalid child");
        arg;
  };

  ctors = {
    raw =
      content:
      assert lib.assertMsg (lib.isString content) "raw called with non-string";
      {
        type = constants.raw;
        inherit content;
      };
    monomorphic =
      tagName_: attributes_: children_:
      let
        tagName = validators.tagName tagName_;
        attributes = validators.attributes tagName attributes_;
        children = validators.children tagName children_;
      in
      {
        type = constants.element;
        inherit tagName attributes children;
      };

    polymorphic =
      tagName:
      let
        partial = ctors.monomorphic tagName;
        isVoid = isVoidTag tagName;
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
        || lib.elem argB.type or null [
          constants.element
          constants.raw
        ]
      then
        argB |> lib.toList |> partial { }
      else if argBType == "set" then
        if isVoid then
          partial argB [ ]
          // {
            __functor = _: _: throw "attempt to pass children to void element ${tagName}";
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
  inherit serialize document bundle;
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
