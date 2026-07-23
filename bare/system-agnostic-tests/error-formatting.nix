{ htnl, lib, ... }:
let
  inherit (htnl) serialize;
  inherit (htnl.polymorphic.partials)
    div
    p
    ;
in
{
  testValidationIsLazy = {
    expr = p { unknown-attr = "foo"; } "bar" |> lib.getAttr "type";
    expected = "htnl-element";
  };

  attributeOmission = {
    idAttrsNotOmitted = {
      testErrorFromChild = {
        expr = div { id = "a"; } [ 0 ] |> serialize;
        expectedError.msg = /* html */ ''
          <div id="id">
            invalid node; type: number, value: `0` [0]
          </div>
        '';
      };
      testErrorFromOtherAttr = {
        expr =
          div {
            id = "a";
            class = 0;
          } [ ]
          |> serialize;
        expectedError.msg = /* html */ ''
          <div class id="id"></div>
               ^^^^^ invalid attribute value; type: number, value: `0`
        '';
      };
    };
    testMostAttributesOmitted = {
      expr =
        div {
          class = "a";
          style = "";
        } [ true ]
        |> serialize;
      expectedError.msg = /* html */ ''
        <div>
          invalid node; type: bool, value: `true` [0]
        </div>
      '';
    };
  };

  snipping = {
    fragments = {
      testEmptyFragmentNotSnipped = {
        expr = p 0 [ ] |> serialize;
        expectedError.msg = /* html */ ''
          <p></p>
          ^^^^^^^ invalid first argument; type: number, value: `0`
        '';
      };
      testValidFragmentNodesAreSnipped = {
        expr =
          [
            "text"
            (p 0 [ ])
            (p "foo")
          ]
          |> serialize;
        expectedError.msg = /* html */ ''
          [⋯]
          <p></p> [1]
              ^^^^^^^ invalid first argument; type: number, value: `0`
          [⋯]
        '';
      };
      testValidChildNodesAreSnipped = {
        expr =
          div { unknown = ""; } [
            (p "foo")
            true
          ]
          |> serialize;
        expectedError.msg = /* html */ ''
          <div>
            [⋯]
            invalid node; type: bool, value: `true` [1]
          </div>
        '';
      };
      testAllChildNodesAreSnipped = {
        expr =
          p { nope = ""; } [
            "a"
            "b"
          ]
          |> serialize;
        expectedError.msg = /* html */ ''
          <p nope="">
             ^^^^ unknown attribute
            [⋯]
          </p>
        '';
      };
      testEmptyChildNodesNotSnipped = {
        expr = p { invalid = 1; } [ ] |> serialize;
        expectedError.msg = /* html */ ''
          <p invalid>
             ^^^^^^^ invalid attribute value; type: number, value: `1`
          </p>
        '';
      };
    };
    attributeValue = {
      testIdNotSnipped = {
        expr = p { id = "0123456789!"; } false |> serialize;
        expectedError.msg = /* html */ ''
          <p id="0123456789!">
            invalid node; type: bool, value: `false`
          </p>
        '';
      };
      testSnippedAfter10Chars = {
        expr = p { schmass = "0123456789!"; } false |> serialize;
        expectedError.msg = /* html */ ''
          <p schmass="0123456789[⋯]">
             ^^^^^^^ unknown attribute
          </p>
        '';
      };
    };
  };

  indices = {
    testPresentRegardlessOfSnipping = {
      expr = [ (p 0) ] |> serialize;
      expectedError.msg = /* html */ ''
        <p></p> [0]
        ^^^^^^^ invalid first argument; type: number, value: `0`
      '';
    };

    testNotForRootNode = {
      expr = p [ 0 ] |> serialize;
      expectedError.msg = /* html */ ''
        <p>
          invalid node; type: number, value: `0` [0]
        </p>
      '';
    };

    testArbitrary = {
      expr =
        [
          (p 0)
          (div [ (p 0) ])
        ]
        |> serialize;
      expectedError.msg = /* html */ ''
        <p></p> [0]
        ^^^^^^^ invalid first argument; type: number, value: `0`
        <div> [1]
          <p></p> [0]
          ^^^^^^^ invalid first argument; type: number, value: `0`
        </div>
      '';
    };

  };

  testMissingSecondArg = {
    expr = p { } |> serialize;
    expectedError.msg = /* html */ ''
      <p></p>
      ^^^^^^^ missing second argument
    '';
  };
  testSecondArgAcceptedAfterInvalidFirstArg = {
    expr = p 0 [ ] |> serialize;
    expectedError.msg = /* html */ ''
      <p></p>
      ^^^^^^^ invalid first argument; type: number, value: `0`
    '';
  };
}
