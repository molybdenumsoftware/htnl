{ htnl, ... }:
let
  inherit (htnl) serialize raw;
  h = htnl.polymorphic.element;
in
{
  # raw content? Yes, but be careful, okay?
  testNonString = {
    expr = raw 0;
    expectedError = {
      type = "ThrownError";
      msg = "raw called with non-string";
    };
  };
  testSingle = {
    expr = h "div" (raw " < ") |> serialize;
    expected = "<div> < </div>";
  };
  testList = {
    expr =
      h "div" [
        (raw " < ")
        (raw " & ")
      ]
      |> serialize;
    expected = "<div> <  & </div>";
  };
}
