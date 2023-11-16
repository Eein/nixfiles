{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nextls = {
      # url = "github:elixir-tools/next-ls";
      url = "github:eein/next-ls";
    };
  };

  outputs = inputs@{ nixpkgs, nextls, home-manager, ... }: {
    nixosConfigurations = {
      nanami = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.will = import ./home.nix;
          }
        ];
      };
      shibusa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.will = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit nextls;
            };
          }
        ];
      };
    };
  };
}
