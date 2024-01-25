# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{
  networking.hostName = "nanami"; # Define your hostname.
  # this needs to be fixed
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
