prev: final: {
  htnl = import ./bare/lib.nix { inherit (prev) lib; } // {
    bundle = prev.callPackage ./bare/bundle.nix { };
  };
}
