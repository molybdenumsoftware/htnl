{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      programs = {
        nixfmt.enable = true;
        prettier.enable = true;
      };
      settings.on-unmatched = "fatal";
    };
  };
}
