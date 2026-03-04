{
  attr,
  path ? ./.,
  dep ? "src",
}:
let
  src = (import path { }).${attr}.${dep};
in
(src.overrideAttrs or (f: src // f src)) (_: {
  outputHash = "";
  outputHashAlgo = "sha256";
})
