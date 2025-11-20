# Bundling tests, a flake-parts module

{ lib, config, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      inherit (config.lib) document bundle;
      h = config.lib.polymorphic.element;

      # Example output:
      # ```
      # {
      #   "a.txt" = "content";
      #   b."c.txt" = "other content"
      # }
      # ```
      readFilesRecursive =
        path:
        builtins.readDir path
        |> lib.mapAttrs (
          fileName: fileType:
          let
            filePath = lib.concatStrings [
              path
              "/"
              fileName
            ];
          in
          if fileType == "directory" then
            readFilesRecursive filePath
          else if fileType == "regular" then
            builtins.readFile filePath
          else
            throw "unsupported file type `${fileType}`"
        );

      assetDrv = pkgs.writeText "file.txt" "some text";

      assertEq =
        actual: expected:
        if actual == expected then
          actual
        else
          [
            "  `actual`:"
            actual
            "  `expected`"
            expected
          ]
          |> lib.foldr lib.trace (throw "Assertion failed. Assertion: `actual == expected`");
    in
    {
      checks = {
        "tests:bundling:with-assets" =
          {
            htmlDocuments = {
              "index.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetDrv; } "Download")
                  ])
                ]
                |> document;
              "blog/first-entry.html" =
                h "html" [
                  (h "body" [
                    (h "a" { href = assetDrv; } "Download")
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
              "index.html" = ''<!DOCTYPE html><html><body><a href="${assetDrv}">Download</a></body></html>'';
              blog."first-entry.html" =
                ''<!DOCTYPE html><html><body><a href="${assetDrv}">Download</a></body></html>'';
              nix.store.${assetDrv |> builtins.baseNameOf |> builtins.unsafeDiscardStringContext} = "some text";
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
              "index.html" = "<!DOCTYPE html><html></html>";
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
    };
}
