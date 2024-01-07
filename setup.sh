sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nixos/disko-configuration.nix

sudo nixos-generate-config --no-filesystems --root /mnt

sudo mv /mnt/etc/nixos /mnt/etc/nixos_aside

sudo cp -r /tmp/nixos /mnt/etc/nixos

# sudo nixos-install  --impure --flake /mnt/etc/nixos#mynewsystem
