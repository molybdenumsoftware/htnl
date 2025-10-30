{ rootPath, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      make-shells.default = {
        env.NIX_PATH = "nixpkgs=${inputs.nixpkgs}";
        packages = [ pkgs.nix-unit ];
      };
      checks.unit-tests =
        pkgs.runCommand "unit-tests"
          {
            env.NIX_PATH = "nixpkgs=${inputs.nixpkgs}";
            nativeBuildInputs = [ pkgs.nix-unit ];
          }
          ''
            export HOME="$(realpath .)"
            nix-unit --eval-store "$HOME" \
              --extra-experimental-features pipe-operators \
              ${rootPath + "/bare"}/tests.nix
            touch $out
          '';
    };
}
