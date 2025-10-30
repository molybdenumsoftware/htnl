{ config, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      path_ = "README.md";
    in
    {
      treefmt.settings.global.excludes = [ path_ ];
      files.files = [
        {
          inherit path_;
          drv =
            let
              inherit (config.lib.polymorphic.partials)
                h1
                p
                a
                code
                ;
            in
            [
              (h1 config.metadata.title)
              config.metadata.description.ir
              (p (
                a { href = config.metadata.website.url; } [
                  (code config.metadata.website.url)
                ]
              ))
            ]
            |> config.lib.serialize
            |> pkgs.writeText "README.md";
        }
      ];
    };
}
