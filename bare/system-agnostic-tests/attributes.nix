{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
  testEscaping = {
    expr = h "br" { class = ''" & < >''; } |> serialize;
    expected = ''<br class="&quot; &amp; &lt; &gt;">'';
  };
  invalid = {
    testNonExistent = {
      expr = h "div" { "no-such-attr" = "nope"; } [ ];
      expectedError = {
        type = "ThrownError";
        msg = "attribute no-such-attr not allowed on tag div";
      };
    };
    testNotAllowed = {
      expr = h "p" { href = "https://fulltimenix.com"; } [ ];
      expectedError = {
        type = "ThrownError";
        msg = "attribute href not allowed on tag p";
      };
    };
  };

  testMultiple = {
    expr =
      h "img" {
        src = "photo.jpg";
        alt = "Photograph";
      }
      |> serialize;
    expected = ''<img alt="Photograph" src="photo.jpg">'';
  };

  boolean = {
    testNonTrue = {
      expr = h "br" { inert = false; };
      expectedError = {
        type = "ThrownError";
        msg = "non-true value for boolean attribute `inert` of tag `br`";
      };
    };
    test = {
      expr = h "hr" { autofocus = true; } |> serialize;
      expected = "<hr autofocus>";
    };
  };
}
