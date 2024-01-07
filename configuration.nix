{ config, lib, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;

  users.users.demo.isNormalUser = true;

  system.stateVersion = "23.11";
}
