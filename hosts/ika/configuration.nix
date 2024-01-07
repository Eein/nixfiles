{ config, pkgs, ... }:
{
  imports = [
    ../../users/will.nix
  ];

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
