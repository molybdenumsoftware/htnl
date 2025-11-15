{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
  testFragments = {
    expr =
      [
        "Check out "
        (h "a" { href = "https://molybdenum.software"; } "The Molybdenum Software Show")
      ]
      |> serialize;
    expected = ''Check out <a href="https://molybdenum.software">The Molybdenum Software Show</a>'';
  };
}
