{ htnl, ... }:
let
  inherit (htnl) serialize document;
  h = htnl.polymorphic.element;
in
{
  testToDocument = {
    expr = h "p" "I am in a document" |> document |> serialize;
    expected = "<!DOCTYPE html><p>I am in a document</p>";
  };
}
