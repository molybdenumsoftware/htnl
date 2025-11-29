{ htnl, lib, ... }:
let
  inherit (htnl) process;
  h = htnl.polymorphic.element;
in
{
  test = {
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
      |> lib.getAttr "headings";

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
}
