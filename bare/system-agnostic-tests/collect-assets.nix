{ htnl, lib, ... }:
let
  inherit (htnl) process raw;
  h = htnl.polymorphic.element;
in
{
  test = {
    expr =
      [
        (h "a" { href = ./asset.txt; } "Download")
        (raw { file = ./asset.txt; } (assets: ''<a href="${assets.file}"''))
      ]
      |> process
      |> lib.getAttr "assets"
      |> lib.attrNames; # the values are the assets themselves

    expected = [
      (builtins.unsafeDiscardStringContext ./asset.txt)
    ];
  };
}
