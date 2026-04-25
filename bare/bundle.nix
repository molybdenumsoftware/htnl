{
  lib,
  runCommand,
  htnl,
}:
{
  name ? "htnl-bundle",
  processing ? { },
  htmlDocuments,
}:
htmlDocuments
|>
  lib.foldlAttrs
    (
      acc: htmlDocumentPath: htmlDocument:
      let
        inherit (htnl.process processing htmlDocument) html assets;

        documentAssetLines =
          assets |> lib.mapAttrsToList (storePath: asset: ''cp --parents -r ${asset} "$out"'');
      in
      [
        acc
        ''mkdir -p "$out/${dirOf htmlDocumentPath}"''
        ''echo -n ${lib.escapeShellArg html} > "$out/${htmlDocumentPath}"''
        documentAssetLines
      ]
    )
    # support empty bundles
    [ ''mkdir -p "$out"'' ]
|> lib.flatten
|> lib.concatLines
|> runCommand name { }
