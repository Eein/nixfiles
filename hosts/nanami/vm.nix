{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ../shared-configuration.nix
    ./configuration.nix
  ];
}
