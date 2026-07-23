{ htnl, ... }:
let
  inherit (htnl) serialize raw;
  h = htnl.polymorphic.element;
in
{
  testInText = {
    expr = "${./context-forbidden.nix}" |> serialize;
    expectedError.msg = /* htnl */ ''
      text node with non-asset context
    '';
  };
  testInElement = {
    expr = h "p" "${./context-forbidden.nix}" |> serialize;
    expectedError.msg = /* htnl */ ''
      <p>
        text node with non-asset context [0]
      </p>
    '';
  };
  testInRaw = {
    expr = raw "${./context-forbidden.nix}" |> serialize;
    expectedError.msg = /* htnl */ ''
      raw node with non-asset context
    '';
  };
}
