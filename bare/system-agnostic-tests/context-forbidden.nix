{ htnl, ... }:
let
  inherit (htnl) serialize raw;
  h = htnl.polymorphic.element;
in
{
  testInText = {
    expr = "${./context-forbidden.nix}" |> serialize;
    expectedError = {
      type = "ThrownError";
      msg = "non-asset context detected";
    };
  };
  testInElement = {
    expr = h "p" "${./context-forbidden.nix}" |> serialize;
    expectedError = {
      type = "ThrownError";
      msg = "non-asset context detected";
    };
  };
  testInRaw = {
    expr = raw "${./context-forbidden.nix}" |> serialize;
    expectedError = {
      type = "ThrownError";
      msg = "non-asset context detected";
    };
  };
}
