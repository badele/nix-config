{ config
, inputs
, pkgs
, lib
, ...
}:
{
  imports = [
    ./commons
    ./features/term
  ];

  home = {
    username = lib.mkDefault "root";
    homeDirectory = lib.mkDefault "/root/";
    stateVersion = lib.mkDefault "22.05";
  };
}
