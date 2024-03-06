#
# Hardware settings for a general VM.
# Works on QEMU Virt-Manager
#
# flake.nix
#  └─ ./hosts
#      └─ ./qemu
#          ├─ default.nix
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
#

{ config, lib, pkgs, modulesPath, host, ... }:

{

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  swapDevices = [ ];

  networking = {
    useDHCP = true;                        # Deprecated
    # hostName = "qemu";
#    interfaces = {
#      enp0s3.useDHCP = true;
#    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  #virtualisation.virtualbox.guest.enable = true;     #currently disabled because package is broken
}