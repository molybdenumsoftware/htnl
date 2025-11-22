# Bundling tests, a flake-parts module

{ lib, config, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      inherit (config.lib) document bundle;
      inherit (config.utils) assertEq readFilesRecursive;
      h = config.lib.polymorphic.element;
      assetDrv = pkgs.writeText "file.txt" "some text";
      assetPath = ./asset.txt;
    in
    {
      checks = {
        "tests:bundling:assets:derivation" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetDrv; } "Download derivation asset")
                  ])
                ]
                |> document;
            };
          }
          |> bundle pkgs
          |> readFilesRecursive
          |> (
            actual:
            lib.seq (assertEq actual {
              "/index.html" =
                [
                  "<!DOCTYPE html>"
                  "<html>"
                  "<body>"
                  ''<a href="${assetDrv}">Download derivation asset</a>''
                  "</body>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetDrv} = "some text";
            }) (pkgs.writeText "" "")
          );

        "tests:bundling:assets:path" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetPath; } "Download path asset")
                  ])
                ]
                |> document;
            };
          }
          |> bundle pkgs
          |> readFilesRecursive
          |> (
            actual:
            lib.seq (assertEq actual {
              "/index.html" =
                [
                  "<!DOCTYPE html>"
                  "<html>"
                  "<body>"
                  ''<a href="${assetPath}">Download path asset</a>''
                  "</body>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetPath} = "asset has content\n";
            }) (pkgs.writeText "" "")
          );

        "tests:bundling:without-assets" =
          {
            htmlDocuments."index.html" = h "html" [ ] |> document;
          }
          |> bundle pkgs
          |> readFilesRecursive
          |> (
            actual:
            lib.seq (assertEq actual {
              "/index.html" = "<!DOCTYPE html><html></html>";
            }) (pkgs.writeText "" "")
          );

        "tests:bundling:empty" =
          {
            htmlDocuments = { };
          }
          |> bundle pkgs
          |> readFilesRecursive
          |> (actual: lib.seq (assertEq actual { }) (pkgs.writeText "" ""));

        "tests:bundling:name:default" =
          {
            htmlDocuments = { };
          }
          |> bundle pkgs
          |> (actual: lib.seq (assertEq actual.name "htnl-bundle") (pkgs.writeText "" ""));

        "tests:bundling:name:provided" =
          {
            htmlDocuments = { };
            name = "some-name";
          }
          |> bundle pkgs
          |> (actual: lib.seq (assertEq actual.name "some-name") (pkgs.writeText "" ""));
      };

      treefmt.settings.global.excludes = [ "dev/modules/tests/bundling/asset.txt" ];
    };
}
