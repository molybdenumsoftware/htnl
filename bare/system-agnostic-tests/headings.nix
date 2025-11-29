{ htnl, lib, ... }:
let
  inherit (htnl) process;
  h = htnl.polymorphic.element;
in
{
  testFlat = {
    expr =
      [
        (h "h1" "Topic")
        (h "h2" { id = "intro"; } "Introduction")
        (h "h3" { id = "background"; } "Background")
        (h "h2" [
          (h "em" "Missing")
          " id"
        ])
      ]
      |> process
      |> lib.getAttrFromPath [
        "headings"
        "flat"
      ];

    expected = [
      {
        level = 1;
        content = "Topic";
      }
      {
        level = 2;
        id = "intro";
        content = "Introduction";
      }
      {
        level = 3;
        id = "background";
        content = "Background";
      }
      {
        level = 2;
        content = "<em>Missing</em> id";
      }
    ];
  };
  testTree = {
    expr =
      [
        (h "h2" "non-h1 root")
        (h "h1" "a")
        (h "h2" { id = "heading-bee"; } "b")
        (h "h3" "c")
        (h "h4" "d")
        (h "h2" "e")
        (h "h3" "f")
        (h "h1" "g")
        (h "h3" "h")
      ]
      |> process
      |> lib.getAttrFromPath [
        "headings"
        "nested"
      ];

    expected = [
      {
        level = 2;
        content = "non-h1 root";
      }
      {
        level = 1;
        content = "a";
        subHeadings = [
          {
            level = 2;
            content = "b";
            id = "heading-bee";
            subHeadings = [
              {
                level = 3;
                content = "c";
                subHeadings = [
                  {
                    level = 4;
                    content = "d";
                  }
                ];
              }
            ];
          }
          {
            level = 2;
            content = "e";
            subHeadings = [
              {
                level = 3;
                content = "f";
              }
            ];
          }
        ];
      }
      {
        level = 1;
        content = "g";
        subHeadings = [
          {
            level = 3;
            content = "h";
          }
        ];
      }
    ];
  };
}
