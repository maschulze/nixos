{ config, lib, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.devices = [ "/dev/vda" ];
    boot.loader.grub.enable = true;

  users.users.demo.isNormalUser = true;

  system.stateVersion = "23.11";
}
