{ config
, pkgs
, ...
}:

{
  imports = [
    ./autologin.nix
    ./backup.nix
    ./locale.nix
    ./networkmanager.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
    ./TODO.nix
  ];

  # Allows users to allow others on their binds
  programs.fuse.userAllowOther = true;
}
