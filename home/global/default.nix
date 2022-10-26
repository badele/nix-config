{ 
inputs
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
  home = {
    username = lib.mkDefault "vagrant";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
  };
}
