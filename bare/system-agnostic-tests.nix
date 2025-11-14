# System-agnostic tests, powered by nix-unit

let
  # Please import from the root of the repo
  # or use the flake output `lib`.
  htnl = import ./impl.nix { inherit lib; };

  inherit (htnl)
    raw
    serialize
    toDocument
    ;

  h = htnl.polymorphic.element;

  # Don't mind this
  lib = import <nixpkgs/lib>;
in
{
  variousSignatures = {
    testBlank = {
      expr = h "p" [ ] |> serialize;
      expected = "<p></p>";
    };
    testSingleAttr = {
      expr = h "a" { href = "/"; } [ ] |> serialize;
      expected = ''<a href="/"></a>'';
    };
    testAttrs = {
      expr =
        h "img" {
          src = "l.png";
          alt = "logo";
        }
        |> serialize;
      expected = ''<img alt="logo" src="l.png">'';
    };
    testWithChildElem = {
      expr = h "span" [ (h "br" { }) ] |> serialize;
      expected = "<span><br></span>";
    };
    testWithChildText = {
      expr = h "span" [ "foo" ] |> serialize;
      expected = "<span>foo</span>";
    };
    testWithSingleChildElem = {
      expr = h "span" (h "br" { }) |> serialize;
      expected = "<span><br></span>";
    };
    testWithSingleChildText = {
      expr = h "span" "hi" |> serialize;
      expected = "<span>hi</span>";
    };
    testwithMultipleTextChildren = {
      expr =
        h "span" [
          "a"
          "b"
        ]
        |> serialize;
      expected = "<span>ab</span>";
    };
    testWithMixedChildren = {
      expr =
        h "span" [
          (h "br" { })
          "text"
        ]
        |> serialize;
      expected = "<span><br>text</span>";
    };
    testWithAttrAndChildren = {
      expr = h "a" { href = "/"; } [ "foo" ] |> serialize;
      expected = ''<a href="/">foo</a>'';
    };
    testWithAttrsAndChild = {
      expr =
        h "a" {
          href = "/";
          target = "_blank";
        } [ "foo" ]
        |> serialize;
      expected = ''<a href="/" target="_blank">foo</a>'';
    };
    testWithAttrAndSingleChild = {
      expr = h "a" { href = "/"; } "foo" |> serialize;
      expected = ''<a href="/">foo</a>'';
    };
  };

  voidElements = {
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
  };

  attributes = {
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
  };

  textNodes = {
    testEscaping = {
      expr = h "p" "& < >" |> serialize;
      expected = "<p>&amp; &lt; &gt;</p>";
    };
  };

  partials =
    let
      inherit (htnl.polymorphic.partials) p a span;
    in
    {
      testSingleText = {
        expr = p "foo" |> serialize;
        expected = "<p>foo</p>";
      };
      testFull = {
        expr = a { href = "/"; } [ (span "text") ] |> serialize;
        expected = ''<a href="/"><span>text</span></a>'';
      };
    };

  testFragments = {
    expr =
      [
        "Check out "
        (h "a" { href = "https://molybdenum.software"; } "The Molybdenum Software Show")
      ]
      |> serialize;
    expected = ''Check out <a href="https://molybdenum.software">The Molybdenum Software Show</a>'';
  };

  testToDocument = {
    expr = h "p" "I am in a document" |> toDocument |> serialize;
    expected = "<!DOCTYPE html><p>I am in a document</p>";
  };

  # raw content? Yes, but be careful, okay?
  raw = {
    testNonString = {
      expr = raw 0;
      expectedError = {
        type = "ThrownError";
        msg = "raw called with non-string";
      };
    };
    testSingle = {
      expr = h "div" (raw " < ") |> serialize;
      expected = "<div> < </div>";
    };
    testList = {
      expr =
        h "div" [
          (raw " < ")
          (raw " & ")
        ]
        |> serialize;
      expected = "<div> <  & </div>";
    };
  };

  tagValidation = {
    invalid = {
      testEmpty = {
        expr = h "" [ ];
        expectedError.type = "AssertionError";
      };
      testNonString = {
        expr = h 100 [ ];
        expectedError.type = "AssertionError";
      };
      testNonAlphaNum = {
        expr = h "has-hyphen" [ ];
        expectedError.type = "AssertionError";
      };
      testOutOfRange = {
        expr = h "¢" [ ];
        expectedError.type = "AssertionError";
      };
    };
    valid = {
      testLowerAlpha = {
        expr = h "a" [ ] |> serialize;
        expected = "<a></a>";
      };
      testUpperAlpha = {
        expr = h "A" [ ] |> serialize;
        expected = "<A></A>";
      };
      testNum = {
        expr = h "0" [ ] |> serialize;
        expected = "<0></0>";
      };
      testCombo = {
        expr = h "aA0" [ ] |> serialize;
        expected = "<aA0></aA0>";
      };
      testComboReverse = {
        expr = h "0Aa" [ ] |> serialize;
        expected = "<0Aa></0Aa>";
      };
    };
  };

  argValidation = {
    children = {
      testWrongType = {
        expr = h "p" [ 0 ];
        expectedError = {
          type = "ThrownError";
          msg = "invalid child";
        };
      };
    };
  };
}
