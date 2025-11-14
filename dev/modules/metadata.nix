{ config, lib, ... }:
{
  options.metadata =
    let
      inherit (config.lib.polymorphic.partials) a p;
    in
    {
      title = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "htnl";
      };
      description = {
        plaintext = lib.mkOption {
          type = lib.types.singleLineStr;
          default = "Nix library for declaring and bundling HTML";
        };
        ir = lib.mkOption {
          type = lib.types.unspecified;
          default = p { } [
            (a { href = "https://nix.dev/tutorials/nix-language"; } "Nix")
            " library for declaring and bundling "
            (a { href = "https://html.spec.whatwg.org"; } "HTML")
          ];
        };
      };
      website.url = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "https://htnl.molybdenum.software/";
      };
      repository.url = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "https://github.com/molybdenumsoftware/htnl";
      };
    };
}
