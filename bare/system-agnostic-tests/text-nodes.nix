{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
  testEscaping = {
    expr = h "p" "& < >" |> serialize;
    expected = "<p>&amp; &lt; &gt;</p>";
  };
}
