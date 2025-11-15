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
}
