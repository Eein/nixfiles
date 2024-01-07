# My Nixfiles

## TODO:
- [ ] LSP

## Installing a machine with flake

### Desktop:

`sudo nixos-rebuild switch --flake '.#shibusa'`

### Laptop:

`sudo nixos-rebuild switch --flake '.#nanami'`

### Homelab

Building a VM to test configuration:

`cd ./hosts/ika/ && sh build_vm.sh`

Building the ISO for the base image:

`cd ./hosts/ika/ && sh build_iso.sh`

## Updating a machines pkg inputs

`nix flake update`

