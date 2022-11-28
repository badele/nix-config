{ config
, pkgs
, ...
}: {

  imports = [
    ./spotify.nix
  ];
}
