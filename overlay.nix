_: prev: {
  htnl = import ./bare/lib.nix { inherit (prev) lib; korora =  } // {
    bundle = prev.callPackage ./bare/bundle.nix { };
  };
}
