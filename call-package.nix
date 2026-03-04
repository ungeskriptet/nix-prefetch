{
  path,
  dep ? "src",
  nixpkgs ? <nixpkgs>,
}:
let
  pkgs = import nixpkgs { };
  src = (pkgs.callPackage path { }).${dep};
in
(src.overrideAttrs or (f: src // f src)) (_: {
  outputHash = "";
  outputHashAlgo = "sha256";
})
