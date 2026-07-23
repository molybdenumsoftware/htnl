{ htnl, ... }:
let
  inherit (htnl) serialize raw;
  h = htnl.polymorphic.element;
in
{
  # raw content? Yes, but be careful, okay?
  testNonString = {
    expr = raw 0 |> serialize;
    expectedError.msg = /* html */ ''
      invalid first argument to `raw`; type: number, value: `0`
    '';
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
  testAsset = {
    expr = raw { file = ./asset.txt; } (assets: ''<a href="${assets.file}">Download</a>'') |> serialize;
    expected = ''<a href="${./asset.txt}">Download</a>'';
  };
  testInvalidAsset = {
    expr = raw { invalid = "foo"; } (assets: assets.invalid) |> serialize;
    expectedError.msg = /* html */ ''
      invalid asset given to `raw`; type: string
    '';
  };
  testNonFunctionSecondArg = {
    expr = raw { } "" |> serialize;
    expectedError.msg = /* html */ ''
      invalid second argument to `raw`; type: string
    '';
  };
}
