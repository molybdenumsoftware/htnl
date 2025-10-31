let
  toDocument = ir: "<!DOCTYPE html>" + toHtml ir;
in
{
  inherit toDocument;
}
