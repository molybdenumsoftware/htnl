{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
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
}
