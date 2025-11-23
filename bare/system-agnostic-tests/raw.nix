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
      msg = "first argument to `raw` must be string or attrset";
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
  testHasContext = {
    expr = raw ''${./raw.nix}'' |> serialize;
    expectedError = {
      type = "ThrownError";
      msg = "`raw` string must have zero context; see documentation.";
    };
  };
  testInvalidAsset = {
    expr = raw { invalid = "string"; } (assets: assets.invalid) |> serialize;
    expectedError = {
      type = "ThrownError";
      msg = "`raw` received invalid asset";
    };
  };
  testNonFunctionSecondArg = {
    expr = raw { } "";
    expectedError = {
      type = "ThrownError";
      msg = "second argument to `raw` must be a function";
    };
  };
}
