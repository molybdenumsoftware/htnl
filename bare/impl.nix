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

  processors = {
    document =
      ir:
      let
        contentResult = processors.element ir.content;
      in
      {
        strings = [
          "<!DOCTYPE html>"
          contentResult.strings
        ];
        inherit (contentResult) headings assets;
      };

    element =
      ir:
      let
        childrenResult = processors.fragment ir.children;
        heading =
          let
            levelStr = lib.match "h([1-6])" ir.tagName |> lib.toList |> lib.head;
            level = if levelStr == null then null else lib.toInt levelStr;
          in
          if level == null then
            null
          else
            {
              inherit level;
              id = ir.attributes.id or null;
              content = childrenResult.strings |> lib.flatten |> lib.concatStrings;
            };
        attributesResult = processors.attributes ir.attributes;
      in
      {
        strings = [
          "<"
          ir.tagName
          (lib.optional (ir.attributes != { }) attributesResult.strings)
          ">"
          (lib.optionals (!isVoidTag ir.tagName) [
            childrenResult.strings
            "</"
            ir.tagName
            ">"
          ])
        ];
        headings = [
          (lib.optional (heading != null) heading)
          childrenResult.headings
        ];
        assets = attributesResult.assets // childrenResult.assets;
      };

    attribute =
      name: value:
      let
        isStoreObject = lib.isPath value || lib.isDerivation value || value ? outPath;
      in
      {
        strings = [
          name
          (lib.optionals (isStoreObject || lib.isString value) [
            ''="''
            ("${value}" |> lib.escapeXML)
            ''"''
          ])
        ];
        assets = lib.optionalAttrs isStoreObject {
          ${value |> toString |> builtins.unsafeDiscardStringContext} = value;
        };
      };

    attributes =
      attributes:
      attributes
      |> lib.attrsToList
      |>
        lib.foldl
          (
            acc:
            { name, value }:
            let
              processedAttr = processors.attribute name value;
            in
            {
              strings = [
                acc.strings
                " "
                processedAttr.strings
              ];
              assets = acc.assets // processedAttr.assets;
            }
          )
          {
            strings = [ ];
            assets = { };
          };

    text = ir: {
      strings = lib.escapeXML ir;
      headings = [ ];
      assets = { };
    };

    fragment =
      ir:
      ir
      |>
        lib.foldl
          (
            acc: child:
            let
              childResult = processors.unknown child;
            in
            {
              strings = [
                acc.strings
                childResult.strings
              ];
              headings = [
                acc.headings
                childResult.headings
              ];
              assets = acc.assets // childResult.assets;
            }
          )
          {
            strings = [ ];
            headings = [ ];
            assets = { };
          };

    raw = ir: {

      strings = ir.content; # no escaping
      assets = { };
    };

    unknown =
      ir:
      let
        type = lib.typeOf ir;
      in
      if type == "string" then
        processors.text ir
      else if type == "list" then
        processors.fragment ir
      else if type == "set" then
        if ir.type or null == constants.document then
          processors.document ir
        else if ir.type or null == constants.element then
          processors.element ir
        else if ir.type or null == constants.raw then
          processors.raw ir
        else
          processors.attributes ir
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
        assert lib.assertMsg (lib.isStringLike value) "non-string-like attribute value";
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

  process =
    ir:
    let
      result = processors.unknown ir;
    in
    {
      inherit (result) assets;
      html = result.strings |> lib.flatten |> lib.concatStrings;
      headings = lib.flatten result.headings;
    };

  serialize = ir: ir |> process |> lib.getAttr "html";

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
            inherit (process htmlDocument) html assets;

            documentAssetLines =
              assets |> lib.mapAttrsToList (storePath: asset: ''cp -r ${asset} "$out/nix/store"'');
          in
          {
            htmlFileLines = lib.concat acc.htmlFileLines [
              ''mkdir -p "$out/${builtins.dirOf htmlDocumentPath}"''
              ''echo -n ${lib.escapeShellArg html} > "$out/${htmlDocumentPath}"''
            ];

            assetLines = acc.assetLines ++ documentAssetLines;
          }
        )
        {
          htmlFileLines = [ ];
          assetLines = [ ];
        }
    |> (
      { htmlFileLines, assetLines }:
      [
        htmlFileLines
        ''mkdir -p "$out"'' # support empty bundles
        (lib.optionalString (assetLines != { }) ''mkdir -p "$out/nix/store"'')
        assetLines
      ]
    )
    |> lib.flatten
    |> lib.concatLines
    |> pkgs.runCommand name { };
in
# public API
{
  inherit
    serialize
    document
    bundle
    ;

  process = ir: { inherit (process ir) html headings; };

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
