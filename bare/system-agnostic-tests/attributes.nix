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

  listValues = {

    testClass = {
      expr =
        h "br" {
          class = [
            "class1"
            "class2"
          ];
        }
        |> serialize;
      expected = ''<br class="class1 class2">'';
    };

    testNotAllowed = {
      expr = h "br" {
        id = [
          "id1"
          "id2"
        ];
      };

      expectedError = {
        type = "ThrownError";
        msg = "list value provided for non-list attribute";
      };
    };

    testSizes = {
      expr =
        h "img" {
          size = [
            "auto"
            "(max-width: 30em) 100vw"
            "50vw"
          ];
        }
        |> serialize;

      expected = ''<img size="auto,(max-width: 30 em) 100vw,50vw">'';
    };

    testAccept = {
      expr =
        h "input" {
          accept = [
            "video/*"
            "image/png"
          ];
        }
        |> serialize;

      expected = ''<input accept="video/*,image/png">'';
    };

    testAutoComplete = {
      expr =
        h "input" {
          autocomplete = [
            "shipping"
            "street-address"
          ];
        }
        |> serialize;

      expected = ''<input autocomplete="shipping street-address">'';
    };

    testAriaDescribedby = {
      expr =
        h "button" {
          aria-describedby = [
            "shipping"
            "street-address"
          ];
        } [ ]
        |> serialize;

      expected = ''<button aria-describedby="shipping street-address">'';
    };
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
