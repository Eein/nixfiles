# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  networking.hostName = "shibusa"; # Define your hostname.
  # this needs to be fixed
  boot.loader.efi.efiSysMountPoint = "/boot/EFI";

  programs.coolercontrol.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    fflogs
    easyeffects
    cdrdao
    via
    obs-studio
  ];
}
