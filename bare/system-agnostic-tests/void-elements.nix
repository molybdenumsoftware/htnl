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
      expr = h "hr" { } [ ];
      expectedError = {
        type = "ThrownError";
        msg = "attempt to pass children to void element hr";
      };
    };
    testElement = {
      expr = h "br" { } (h "p" "foo");
      expectedError = {
        type = "ThrownError";
        msg = "attempt to pass children to void element br";
      };
    };
    testText = {
      expr = h "img" { } "text";
      expectedError = {
        type = "ThrownError";
        msg = "attempt to pass children to void element img";
      };
    };
  };

}
