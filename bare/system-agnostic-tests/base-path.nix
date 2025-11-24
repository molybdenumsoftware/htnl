{ htnl, lib, ... }:
let
  inherit (htnl) process raw;
  h = htnl.polymorphic.element;
in
{
  testBasePath = {
    expr =
      h "div" [
        (h "a" { href = ./asset.txt; } "Download asset")
        (raw { file = ./asset.txt; } (assets: ''<a href="${assets.file}">Download asset</a>''))
      ]
      |> process { basePath = "/non-default/"; }
      |> lib.getAttr "html";
    expected =
      [
        "<div>"
        ''<a href="/non-default${./asset.txt}">Download asset</a>''
        ''<a href="/non-default${./asset.txt}">Download asset</a>''
        "</div>"
      ]
      |> lib.concatStrings;
  };
}
