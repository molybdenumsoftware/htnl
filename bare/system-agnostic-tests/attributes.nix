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
      expr =
        h "br" {
          id = [
            "id1"
            "id2"
          ];
        }
        |> serialize;

      expectedError.msg = ''
        <br id>
            ^^ invalid attribute value; type: list
      '';
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
      expr = h "div" { "no-such-attr" = "nope"; } [ ] |> serialize;
      expectedError.msg = ''
        <div no-such-attr="nope"></div>
             ^^^^^^^^^^^^ unknown attribute
      '';
    };
    testNotAllowed = {
      expr = h "p" { href = "https://fulltimenix.com"; } [ ] |> serialize;
      expectedError.msg = ''
        <div href="nope"></div>
             ^^^^ unknown attribute
      '';
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
      expr = h "br" { inert = false; } |> serialize;
      expectedError.msg = ''
        <br inert>
            ^^^^^ non-true value for boolean attribute
      '';
    };
    test = {
      expr = h "hr" { autofocus = true; } |> serialize;
      expected = "<hr autofocus>";
    };
  };
}
