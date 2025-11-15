{ htnl, ... }:
let
  inherit (htnl) serialize;
  inherit (htnl.polymorphic.partials) p a span;
in
{
  testSingleText = {
    expr = p "foo" |> serialize;
    expected = "<p>foo</p>";
  };
  testFull = {
    expr = a { href = "/"; } [ (span "text") ] |> serialize;
    expected = ''<a href="/"><span>text</span></a>'';
  };
}
