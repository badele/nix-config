{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    spotify-tui
    ncspot
    playerctl
  ];

  services = {
    playerctld = {
      enable = true;
    };

    spotifyd = {
      enable = true;
      settings = ''
        {
          global = {
            username = ${config.sops.secrets."spotify/user"};
            password = ${config.sops.secrets."spotify/password"};
            device_name = "nix";
          };
        }
      '';
    };
  };

  sops.secrets."spotify/user" = {
    sopsFile = ../../nixos/secrets.yaml;
    neededForUsers = true;
  };

  sops.secrets."spotify/password" = {
    sopsFile = ../../nixos/secrets.yaml;
    neededForUsers = true;
  };

  home.persistence = {
    "/persist/user".directories = [
      ".config/spotify"
      ".config/ncspot"
    ];
  };
}
