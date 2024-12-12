{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, lix-module, home-manager, nixos-hardware, ... }: {
    nixosConfigurations = {
      nanami = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          ./hosts/nanami/hardware-configuration.nix
          ./hosts/shared-configuration.nix
          ./hosts/nanami/configuration.nix
          lix-module.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.will = import ./home.nix;
          }
        ];
      };
      shibusa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/shibusa/hardware-configuration.nix
          ./hosts/shared-configuration.nix
          ./hosts/shibusa/configuration.nix
          lix-module.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.will = import ./home.nix;
          }
        ];
      };
    };
  };
}
