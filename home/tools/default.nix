{ config
, pkgs
, ...
}: {

  imports = [
    ./inxi.nix
    ./system.nix
  ];
}
