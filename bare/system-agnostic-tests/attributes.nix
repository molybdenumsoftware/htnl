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
          sizes = [
            "auto"
            "(max-width: 30em) 100vw"
            "50vw"
          ];
        }
        |> serialize;

      expected = ''<img sizes="auto,(max-width: 30em) 100vw,50vw">'';
    };

    testImagesizes = {
      expr =
        h "link" {
          imagesizes = [
            "(width < 400px) 200px"
            "(400px <= width < 600px) 75vw"
            "50vw"
          ];
        }
        |> serialize;

      expected = ''<link imagesizes="(width &lt; 400px) 200px,(400px &lt;= width &lt; 600px) 75vw,50vw">'';
    };

    testImagesrcset = {
      expr =
        h "link" {
          imagesrcset = [
            "images/team-photo.jpg"
            "images/team-photo-retina.jpg 2x"
            "images/team-photo-large.jpg 1400w"
          ];
        }
        |> serialize;

      expected = ''<link imagesrcset="images/team-photo.jpg,images/team-photo-retina.jpg 2x,images/team-photo-large.jpg 1400w">'';
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

    testAutocomplete = {
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

      expected = ''<button aria-describedby="shipping street-address"></button>'';
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
