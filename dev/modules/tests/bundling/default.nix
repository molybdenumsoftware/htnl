# Bundling tests, a flake-parts module

{
  lib,
  config,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      inherit (config.lib) document bundle raw;
      inherit (config.utils) assertEq readFilesRecursive;
      h = config.lib.polymorphic.element;
      assetDrv = pkgs.writeText "file.txt" "some text";
      assetPath = ./asset.txt;
      assetFlakeInput = inputs.asset-for-testing;
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

        "tests:bundling:assets:flake-input" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetFlakeInput; } "Download flake input asset")
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
                  ''<a href="${assetFlakeInput}">Download flake input asset</a>''
                  "</body>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetFlakeInput} = ''
                User-agent: *
                Disallow: /deny
              '';
            }) (pkgs.writeText "" "")
          );

        "tests:bundling:assets:in-raw" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "head" [
                    (h "script" (
                      raw { inherit assetDrv assetPath assetFlakeInput; } (
                        {
                          assetDrv,
                          assetPath,
                          assetFlakeInput,
                        }:
                        ''
                          console.log({
                            drv: '${assetDrv}',
                            path: '${assetPath}',
                            flakeInput: '${assetFlakeInput}',
                          })
                        ''
                      )
                    ))
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
                  "<head>"
                  "<script>"
                  ''
                    console.log({
                      drv: '${assetDrv}',
                      path: '${assetPath}',
                      flakeInput: '${assetFlakeInput}',
                    })
                  ''
                  "</script>"
                  "</head>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetDrv} = "some text";
              ${builtins.unsafeDiscardStringContext assetPath} = "asset has content\n";
              ${builtins.unsafeDiscardStringContext assetFlakeInput} = ''
                User-agent: *
                Disallow: /deny
              '';
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

        "tests:bundling:assets:same-drv-multiple-positions" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetDrv; } "Download derivation asset")
                    (h "a" { href = assetDrv; } "Download same derivation asset")
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
                  ''<a href="${assetDrv}">Download same derivation asset</a>''
                  "</body>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetDrv} = "some text";
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

        "tests:bundling:base-path" =
          {
            processing.basePath = "/website/";
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
                  ''<a href="/website${assetPath}">Download path asset</a>''
                  "</body>"
                  "</html>"
                ]
                |> lib.concatStrings;
              ${builtins.unsafeDiscardStringContext assetPath} = "asset has content\n";
            }) (pkgs.writeText "" "")
          );
      };

      treefmt.settings.global.excludes = [ "dev/modules/tests/bundling/asset.txt" ];
    };
}
