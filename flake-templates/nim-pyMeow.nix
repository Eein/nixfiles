{
  description = "A Nix-flake-based Nim development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.xorg.libX11
            pkgs.xorg.libXcursor
            pkgs.xorg.libXrandr
            pkgs.xorg.libXinerama
            pkgs.xorg.libXi
          ];
          postShellHook = ''
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath[
              pkgs.xorg.libX11
              pkgs.xorg.libXcursor
              pkgs.xorg.libXrandr
              pkgs.xorg.libXinerama
              pkgs.xorg.libXi
            ]};
          '';
          packages = with pkgs; [ nim nimble ];
        };
      });
    };
}
