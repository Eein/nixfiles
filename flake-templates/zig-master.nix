{
  inputs = {
    zig = {
      url = "github:mitchellh/zig-overlay";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, zig, nixpkgs }:
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
    {
      devShell.x86_64-linux =
        pkgs.mkShell {
          buildInputs = [
            zig.packages.x86_64-linux.master
            pkgs.nixpkgs-fmt
            pkgs.zls
          ];
        };
    };
}
