{
  inputs = {
    files.url = "github:mightyiam/files";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "dedupe_flake-compat";
      };
    };

    import-tree.url = "github:vic/import-tree";

    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs.flake-compat.follows = "dedupe_flake-compat";
    };

    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    systems.url = "github:nix-systems/default";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # _additional_ `inputs` only for deduplication
  inputs = {
    dedupe_flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs = _: { };
}
