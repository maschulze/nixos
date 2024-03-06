{ pkgs, disko, ... }:

{

  imports = [
    ./hardware-configuration.nix
    (import ../shared/disko/simple-bios.nix { device = "/dev/vda"; })
    # ./home.nix

    # Apps definitions
    ../shared/apps

    # Module definitions
    ../shared/modules

    # Service definitions
    ../shared/services
  ];

  boot = {
    # Boot Options
    loader = {
      grub = {
        enable = true;
        # device = "/dev/vda";
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

  apps.system.git.enable = true;


  environment.systemPackages = with pkgs; [
    neofetch
  ];

  # Whether to install NixOS’s own documentation.
  #
  # - This includes man pages like configuration.nix(5), if documentation.man.enable is set.
  # - This includes the HTML manual and the nixos-help command, if documentation.doc.enable is set.
  documentation.nixos.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
