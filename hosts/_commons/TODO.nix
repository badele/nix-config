# This file (and the global directory) holds config that i use on all hosts
{ lib, inputs, outputs, ... }: {
  imports = [
    #    ./sudo.nix
  ];

  security.sudo.wheelNeedsPassword = false;
  networking.domain = "adele.local";
  virtualisation.docker.enable = true;

  environment = {
    loginShellInit = ''
      # Activate home-manager environment, if not already
      [ -d "~/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
    '';

    # Add terminfo files
    enableAllTerminfo = true;
  };

  # Boot limit
  boot.loader.systemd-boot.configurationLimit = 20;

  # Autologin
  services.getty.autologinUser = "badele";


  hardware.enableRedistributableFirmware = true;
}
