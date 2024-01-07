{ config, pkgs, system, ... }:

let

in
{
  # imports = [ ./cachix.nix ];

  system.stateVersion = "23.11";

  nix = {

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      # trusted-users = [ "root" "@wheel" ];
      # sandbox = "relaxed";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # NVIDIA requires nonfree
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Europa/Berlin";

  # hardware.bluetooth.enable = true;
  # hardware.enableAllFirmware = true;

  # sound
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # services.pipewire = {
  #   enable = true;
  #   alsa = {
  #     enable = true;
  #     support32Bit = true;
  #   };
  #   jack.enable = true;
  #   pulse.enable = true;
  # };

  # virtualization
  # virtualisation.libvirtd.enable = true;

  # vmVariant configuration is added only when building VM with nixos-rebuild
  # build-vm
  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     memorySize = 8192; # Use 8GB memory (value is in MB)
  #     cores = 4;
  #   };
  # };

  # default shell for all users
  # users.defaultUserShell = pkgs.zsh;
  # programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # nvidia-offload
  ];
}
