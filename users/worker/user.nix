{ config, pkgs, home-manager, ... }:

{
  # Define a user account.
  users.users.worker = {
    isNormalUser = true;
    initialPassword = "worker";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      # "docker"
      "nixconfig"
      # "dialout"
      # "libvirtd"
      # "wireshark"
    ];
  };

}
