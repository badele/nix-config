{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [ discord ];

  home.persistence = {
    "/persist/user".directories = [ ".config/discord" ];
  };
}
