{ inputs, rootPath, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = { };
        overlays = [ (rootPath + "/overlay.nix" |> import) ];
      };
    };
}
