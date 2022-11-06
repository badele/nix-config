{ config
, pkgs
, ...
}:

{
  imports = [
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./network.nix
  ];
}
