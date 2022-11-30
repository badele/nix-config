{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    playerctl
  ];

  services.playerctld = {
    enable = true;
  };

  home.persistence = {
    "/persist/user".directories = [ ".config/spotify" ];
  };
}
