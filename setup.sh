#!/bin/bash

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nixos/hardware/disko-configuration.nix

sudo nixos-generate-config --no-filesystems --root /mnt

sudo mv /tmp/nixos/hardware/disko-configuration.nix /mnt/etc/nixos

sudo nixos-install