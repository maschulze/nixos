{ config, lib, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];


  # boot.loader.grub.enable = true;
  # # boot.loader.grub.device = "/dev/vda";
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.grub.useOSProber = false;

  networking.hostName = "myhost";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  console.keyMap = "de-latin1-nodeadkeys";

  users.users.worker = {
    isNormalUser = true;
    description = "Worker";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "23.11";
}
