{ pkgs, ... }:
{
  home.packages = [
    pkgs.pinentry
    pkgs.unzip
    pkgs.xclip
    pkgs.pavucontrol
    pkgs.pciutils
    pkgs.killall
    pkgs.magic-wormhole
  ];
}
