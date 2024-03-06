sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/shared/disko/simple-bios.nix --arg device '"/dev/sda"'

sudo nixos-install --flake .#hypernix
