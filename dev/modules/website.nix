{
  inputs,
  config,
  lib,
  rootPath,
  ...
}:
{
  perSystem =
    psArgs@{ pkgs, ... }:
    let
      workflowPath = ".github/workflows/publish-website.yaml";

      website =
        let
          inherit (config.lib)
            raw
            document
            bundle
            ;
          inherit (config.lib.polymorphic.partials)
            a
            body
            code
            div
            em
            head
            html
            img
            link
            meta
            p
            pre
            title
            script
            ;
        in
        html { lang = "en"; data-theme = "dark"; } [
          (head [
            (meta { charset = "UTF-8"; })
            (meta {
              name = "viewport";
              content = "width=device-width, initial-scale=1.0";
            })
            (meta {
              name = "description";
              content = config.metadata.description.plaintext;
            })
            (title config.metadata.title)
            (link {
              rel = "stylesheet";
              href = "./style.css";
            })
            (link {
              rel = "stylesheet";
              href = inputs.highlightjs-stylesheet |> lib.readFile |> pkgs.writeText "highlightjs.css";
            })

            (script { type = "module"; } (
              raw
                {
                  highlightjs-esmodule =
                    inputs.highlightjs-esmodule |> lib.readFile |> pkgs.writeText "highlightjs.js";
                  highlightjs-nix = inputs.highlightjs-nix |> lib.readFile |> pkgs.writeText "highlightjs-nix.js";
                }
                (
                  { highlightjs-esmodule, highlightjs-nix }: # js
                  ''
                    import hljs from '${highlightjs-esmodule}';
                    import nix from '${highlightjs-nix}';
                    hljs.registerLanguage('nix', nix);
                    hljs.highlightAll()
                  ''
                )
            ))
          ])
          (body
            {
              class =
                [
                  "bg-black"
                  "text-white"
                  "p-[5vw]"
                  "flex"
                  "flex-col"
                  "gap-[10vh]"
                ]
                |> lib.concatStringsSep " ";
            }
            [
              (div { class = "prose prose-invert"; } [
                (p [
                  "You've been hand-writing HTML string literals in Nix-lang—"
                  (em "admit it.")
                ])
                (p "It's tedious. It's unsafe. Stop it.")
                (p "we are Nixers, we can make things. here is a ${config.metadata.description.plaintext}.")
              ])
              (img {
                src = rootPath + "/dev/modules/graphics/banner.svg";
                alt = "Banner";
              })
              (
                let
                  dir = rootPath + "/bare/system-agnostic-tests";
                in
                dir
                |> builtins.readDir
                |> lib.mapAttrsToList (
                  fileName: _:
                  div [
                    (p [
                      (code fileName)
                      ":"
                    ])
                    (pre { class = "overflow-scroll"; } (
                      code { class = "language-nix"; } (dir + "/${fileName}" |> lib.readFile)
                    ))
                  ]
                )
              )

              (div [
                (p { } [
                  "It even "
                  (em "bundles")
                  " for you 🫢"
                ])

                (pre { class = "overflow-scroll"; } (
                  code { class = "language-nix"; } (
                    rootPath + "/dev/modules/tests/bundling/default.nix" |> lib.readFile
                  )
                ))
              ])

              (div { class = "prose prose-invert"; } [
                (
                  p
                  <| lib.concatLines [
                    "This library produces HTML intermediate representation values (hereinafter IR)."
                    "Attributes of IR that are documented are, of course, public."
                    "Undocumented ones are private and considered unstable."
                  ]
                )
              ])

              (p { } [ "Enforces correct tag hierarchy? No" ])

              (p { } [ "CSS specific features? No" ])

              (p { } [ "SVG support? No" ])

              (p { } [ "Requires IFD? No, this is pure lib" ])

              (p { } [ "Available as both flake and bare Nix" ])

              (p { } [ "Go and rebuild the web in Nix!" ])

              (p { } [ "Requires experimental feature pipe-operators" ])

              (p { } [ "Sorry" ])

              (p { } [ "(not sorry)" ])

              (a { href = config.metadata.repository.url; } (code config.metadata.repository.url))
            ]
          )
        ]
        |> document
        |> (indexHtml: {
          name = "${config.metadata.title}-website-bundle";
          htmlDocuments."index.html" = indexHtml;
        })
        |> bundle pkgs
        |> (
          bundle:
          pkgs.runCommand "${config.metadata.title}-website"
            {
              nativeBuildInputs = [
                pkgs.validator-nu
                pkgs.tailwindcss_4
              ];
            }
            ''
              mkdir $out
              cp -r ${bundle}/* $out
              html_files=$(find -L $out -not -path $out'/nix/store/*' -type f)
              vnu --Werror $html_files
              tailwindcss -i ${inputCss} --cwd $out -o $out/style.css
            ''
        );

      inputCss = pkgs.writeText "input.css" ''
        @import "tailwindcss";
        @plugin "@tailwindcss/typography";
      '';
    in
    {
      packages = { inherit website; };
      checks = { inherit website; };

      make-shells.default.inputsFrom = [
        psArgs.config.packages.website
      ];

      files.files = [
        {
          path_ = workflowPath;
          drv = pkgs.writers.writeJSON "gh-actions-workflow-publish-website.yaml" {
            on = {
              pull_request = { };
              push.branches = [ "master" ];
            };

            permissions = {
              contents = "read";
              pages = "write";
              id-token = "write";
            };

            concurrency = {
              group = "\${{ github.workflow }}-\${{ github.ref_name }}";
              cancel-in-progress = true;
            };

            jobs.publish-website = {
              runs-on = "ubuntu-latest";
              steps = [
                { uses = "actions/checkout@v4"; }
              ]
              ++ config.githubActions.setUpNix
              ++ [
                { run = "nix build -vv --print-build-logs --accept-flake-config .#website"; }
                {
                  uses = "actions/upload-pages-artifact@v4";
                  "with".path = "result";
                }
                {
                  "if" = "github.ref == 'refs/heads/\${{ github.event.repository.default_branch }}'";
                  uses = "actions/deploy-pages@v4";
                }
              ];
            };
          };
        }
      ];

      treefmt.settings.global.excludes = [ workflowPath ];
    };

}
