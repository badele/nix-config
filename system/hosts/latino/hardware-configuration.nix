# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "zfs" ];
  #  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  #  boot.zfs.extraPools = [ "latino" ]; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  fileSystems."/" =
    {
      device = "latino/local/root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/9396-DBCC";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    {
      device = "latino/local/nix";
      fsType = "zfs";
    };

  fileSystems."/data" =
    {
      device = "latino/data";
      fsType = "zfs";
    };

  fileSystems."/persist/host" =
    {
      device = "latino/persist/host";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/persist/user" =
    {
      device = "latino/persist/user";
      fsType = "zfs";
      neededForBoot = true;
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "latino";
  networking.hostId = "c350cdee";
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
