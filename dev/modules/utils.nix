{ lib, config, ... }:
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
            config.utils.readFilesRecursive filePath
          else if fileType == "regular" then
            builtins.readFile filePath
          else
            throw "unsupported file type `${fileType}`"
        );
    };
  };
}
