{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
  invalid = {
    testEmpty = {
      expr = h "" [ ] |> serialize;
      expectedError.msg = /* html */ ''
        <>
        ^^ empty tag name
        </>
      '';
    };
    testNonString = {
      expr = h 100 [ ] |> serialize;
      expectedError.msg = /* html */ ''
        <>
        ^^ non-string tag name; type: number, value: `100`
        </>
      '';
    };
    testNonAlphaNum = {
      expr = h "has-hyphen" [ ] |> serialize;
      expectedError.msg = /* html */ ''
        <has-hypen>
            ^ invalid char
        </has-hyphen>
      '';
    };
    testOutOfRange = {
      expr = h "¢" [ ] |> serialize;
      expectedError.msg = /* html */ ''
        <¢>
         ^ invalid char
        </¢>
      '';
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
