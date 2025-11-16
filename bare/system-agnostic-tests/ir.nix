{ htnl, lib, ... }:
let
  inherit (htnl) raw document;
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
      expr = h "html" [ ] |> document |> lib.getAttr "type";
      expected = "htnl-document";
    };
  };
}
