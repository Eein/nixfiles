#!/usr/bin/env bash

nix-build '<nixpkgs/nixos>' -A vm \
-I nixpkgs=channel:nixos-23.11 \
-I nixos-config=./vm.nix
