{ htnl, ... }:
let
  inherit (htnl) serialize;
  h = htnl.polymorphic.element;
in
{
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
}
