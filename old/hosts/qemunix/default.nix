{ pkgs, disko, ... }:

{

  imports = [
    ./hardware-configuration.nix
    (import ../shared/disko/simple-bios.nix { device = "/dev/vda"; })
    # ./home.nix
  ];

  boot = {
    # Boot Options
    loader = {
      grub = {
        enable = true;
        #        device = "/dev/sda";
      };
      timeout = 1;
    };
    # tmp = {
    #   useTmpfs = true;
    # };
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 3; # silence BIOS-related "errors" at boot shown before NixOS stage 1 output (default is 4)
  };

  networking.hostName = "qemunix";

  environment.systemPackages = with pkgs; [
    neofetch
  ];

  # Whether to install NixOS’s own documentation.
  #
  # - This includes man pages like configuration.nix(5), if documentation.man.enable is set.
  # - This includes the HTML manual and the nixos-help command, if documentation.doc.enable is set.
  documentation.nixos.enable = false;
}
