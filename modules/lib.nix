{
  lib,
  rootPath,
  ...
}:
{
  options.lib = lib.mkOption {
    type = lib.types.unspecified;
    default = import rootPath { inherit lib; };
  };
}
