{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ./configuration.nix
    ../shared-configuration.nix
    ../../users/will.nix
  ];
}
