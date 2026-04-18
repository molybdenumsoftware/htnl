{ htnl, ... }:
let
  h = htnl.polymorphic.element;
in
{
  children = {
    testWrongType = {
      expr = h "p" [ 0 ];
      expectedError = {
        type = "ThrownError";
        msg = "invalid child";
      };
    };
  };
  cannotBeSerialized = {
    testUnknownSet = {
      expr = { type = "some unknown type"; } |> htnl.process;
      expectedError = {
        type = "ThrownError";
        msg = "cannot be serialized";
      };
    };
    testUnknownValue = {
      expr = 0 |> htnl.process;
      expectedError = {
        type = "ThrownError";

        msg = "cannot serialize value \\(type: int\\)";
      };
    };
  };
}
