{ config, pkgs, ... }:
{
  imports = [
    ../../users/will.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.forceImportRoot = false;

  # Create 2 virtual disk with 1GB
  virtualisation.emptyDiskImages = [ 1024 1024 1024 ]; 

  fileSystems."/" =
    { device = "zpool/root";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/var" =
    { device = "zpool/var";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
      neededForBoot = true;
    };

  networking.hostId = "ac41cdc4";
  networking.hostName = "ika";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.sshd.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
  ];

  system.stateVersion = "23.11";
}
