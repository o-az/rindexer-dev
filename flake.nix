{
  description = "rindexer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell =
          with pkgs;
          pkgs.mkShell {
            buildInputs = [
              just
              usql
              biome
              direnv
              railway
              sqlfluff
              nixfmt-rfc-style
              cargo-pgrx_0_11_3
            ];
          };
      }
    );
}
