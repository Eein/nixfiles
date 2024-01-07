{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ./configuration.nix
  ];

  environment.etc."scripts/zfs_setup.fish" = {
    mode = "0777";
    text = ''
      #!/usr/bin/env bash

      function setup_zfs
        set -l pool_response (zpool status)
        if test -z "$pool_response" -a "no pools available";
          sudo zpool create spaghetti mirror /dev/vdb /dev/vdc;
          echo "Pool Created";
        else
          echo "Pools Already Exist";
        end
      end

      setup_zfs
    '';
  };
}
