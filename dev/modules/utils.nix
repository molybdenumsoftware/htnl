{ lib, ... }:
{
  options.utils = {
    assertEq = lib.mkOption {
      readOnly = true;
      type = lib.types.functionTo lib.types.unspecified;
      default =
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
    };

    readFilesRecursive = lib.mkOption {
      readOnly = true;
      type = lib.types.functionTo lib.types.unspecified;
      description = ''
        Example output:
        ```
        {
          "a.txt" = "content";
          b."c.txt" = "other content"
        }
        ```
      '';

      default =
        rootDir:
        let
          recurse =
            relDir:
            lib.concatStrings [
              rootDir
              "/"
              relDir
            ]
            |> builtins.readDir
            |> lib.concatMapAttrs (
              fileName: fileType:
              let
                relPath = "${relDir}/${fileName}";
              in
              if fileType == "regular" then
                {
                  ${relPath} =
                    [
                      rootDir
                      "/"
                      relPath
                    ]
                    |> lib.concatStrings
                    |> builtins.readFile;
                }
              else if fileType == "directory" then
                recurse relPath
              else
                throw "unsupported file type `${fileType}`"
            );
        in
        recurse "";
    };
  };
}
