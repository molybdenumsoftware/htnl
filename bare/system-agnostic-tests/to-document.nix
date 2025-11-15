{ htnl, ... }:
let
  inherit (htnl) serialize toDocument;
  h = htnl.polymorphic.element;
in
{
  testToDocument = {
    expr = h "p" "I am in a document" |> toDocument |> serialize;
    expected = "<!DOCTYPE html><p>I am in a document</p>";
  };
}
