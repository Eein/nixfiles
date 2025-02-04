#!/usr/bin/env bash

NIXPKGS_ALLOW_UNFREE=1 nix-build '<nixpkgs/nixos>' -A vm \
-I nixpkgs=channel:nixos-unstable \
-I nixos-config=./vm.nix
