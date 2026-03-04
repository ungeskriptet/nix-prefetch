{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      packages = forAllSystems (system: {
        default = self.packages.${system}.nix-prefetch;
        nix-prefetch = nixpkgs.legacyPackages.${system}.callPackage (
          { runCommand }:
          runCommand "nix-prefetch" { meta.mainProgram = "nix-prefetch"; } ''
            mkdir -p $out/bin
            substitute ${./nix-prefetch.sh} $out/bin/nix-prefetch \
              --replace-fail "custom.nix" "${./custom.nix}" \
              --replace-fail "call-package.nix" "${./call-package.nix}"
            chmod 755 $out/bin/nix-prefetch
          ''
        ) { };
      });
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
