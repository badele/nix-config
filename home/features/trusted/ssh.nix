{ lib, ... }:
{
  programs.ssh = {
    enable = true;
  };

  home.persistence = {
    "/persist/user".directories = [ ".ssh" ];
  };
}
