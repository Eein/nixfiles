# My Nixfiles

## TODO:
- [ ] LSP

## Installing a machine with flake

### Desktop:

`sudo nixos-rebuild switch --flake '.#shibusa'`

#### New installation

`sudo nixos-install --flake '.#shibusa' --impure`

### Laptop:

`sudo nixos-rebuild switch --flake '.#nanami'`

#### New installation

`sudo nixos-install --flake '.#nanami' --impure`

### Homelab

Building a VM to test configuration:

`cd ./hosts/ika/ && sh build_vm.sh`

Building the ISO for the base image:

`cd ./hosts/ika/ && sh build_iso.sh`

## Updating a machines pkg inputs

`nix flake update`

## Cloudflare Warp

To use cloudflare warp, copy the cert file to the root of the repo.

