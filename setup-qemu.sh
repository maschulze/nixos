sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nixos/hosts/shared/disko/simple-bios.nix --arg device '"/dev/vda"'

sudo nixos-install --flake /tmp/nixos#qemunix