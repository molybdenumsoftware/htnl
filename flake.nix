{
  nixConfig = {
    abort-on-warn = true;
    allow-import-from-derivation = false;
    extra-experimental-features = [ "pipe-operators" ];
  };

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };

    nixpkgs-lib.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      {
        flake.lib = import ./lib.nix;

        _module.args.rootPath = ./.;

        systems = [ ];

        imports = [
          inputs.flake-parts.flakeModules.partitions
        ];

        partitionedAttrs = lib.genAttrs [
          "checks"
          "devShells"
          "formatter"
          "packages"
        ] (_: "dev");

        partitions.dev = {
          extraInputsFlake = ./dev;
          module = ./dev/imports.nix;
        };
      }
    );
}
