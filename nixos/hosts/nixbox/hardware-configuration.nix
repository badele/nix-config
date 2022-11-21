{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  nixpkgs.hostPlatform = "x86_64-linux";

  boot.initrd.availableKernelModules = [ "ata_piix" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/71a40272-2f4a-4a9f-8d20-ff6ad9077fcd";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  virtualisation.virtualbox.guest.enable = true;

}
