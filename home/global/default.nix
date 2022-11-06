{ inputs
, lib
, pkgs
, config
, outputs
, ...
}:

{
  imports = [ ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  xdg.enable = true;
}
