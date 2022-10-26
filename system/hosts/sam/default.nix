{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.unfree = true;

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
      networks = { "JSL22" = { psk = "@JSL22_KEY@"; }; };
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  services.sshd.enable = true;
  services.openssh.permitRootLogin = "yes";

  system.stateVersion = "22.05";
}
