{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = "sam";
    wireless = {
      enable = true;
      fallbackToWPA2 = false;
      # Declarative
      environmentFile = "/etc/vault/secrets.env";
      networks = { "@DEFAULT_SSID@" = { psk = "@DEFAULT_PSK@"; }; };
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  system.stateVersion = "22.05";
}
