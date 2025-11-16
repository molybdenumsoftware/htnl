{ htnl, lib, ... }:
let
  inherit (htnl) raw toDocument;
  h = htnl.polymorphic.element;
in
{
  typeAttribute = {
    testElement = {
      expr = h "p" "hi" |> lib.getAttr "type";
      expected = "htnl-element";
    };
    testRaw = {
      expr = raw "content" |> lib.getAttr "type";
      expected = "htnl-raw";
    };
    testDocument = {
      expr = h "html" [ ] |> toDocument |> lib.getAttr "type";
      expected = "htnl-document";
    };
  };
}
