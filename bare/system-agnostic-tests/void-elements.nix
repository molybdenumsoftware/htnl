{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
  testEmptyAttrs = {
    expr = h "br" { } |> serialize;
    expected = "<br>";
  };
  testWithAttr = {
    expr = h "br" { class = "foo"; } |> serialize;
    expected = ''<br class="foo">'';
  };
  childrenErrors = {
    testList = {
      expr = h "hr" { } [ ] |> serialize;
      expectedError.msg = /* html */ ''
        <hr>
        ^^^^ void element received extra argument; type: list
      '';
    };
    testElement = {
      expr = h "br" { } (h "p" "foo");
      expectedError.msg = /* html */ ''
        <br>
        ^^^^ void element received extra argument; type: set
      '';
    };
    testText = {
      expr = h "img" { } "text";
      expectedError.msg = /* html */ ''
        <img>
        ^^^^^ void element received extra argument; type: string
      '';
    };
  };

}
