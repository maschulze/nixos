#!/bin/bash

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nixos/hardware/disko-configuration.nix