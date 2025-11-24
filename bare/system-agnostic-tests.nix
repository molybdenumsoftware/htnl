let
  htnl = import ./impl.nix { inherit lib; };
  lib = import <nixpkgs/lib>;
  dir = ./system-agnostic-tests;
in
dir
|> builtins.readDir
|> lib.filterAttrs (fileName: _: lib.hasSuffix ".nix" fileName)
|> lib.mapAttrs (fileName: _: import "${dir}/${fileName}" { inherit htnl lib; })
