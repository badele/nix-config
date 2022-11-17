{ config
, pkgs
, ...
}:

{
  imports = [
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./TODO.nix
  ];

  # TODO: reove this
  environment.systemPackages = with pkgs; [
    pciutils
    glxinfo
  ];


  # Allows users to allow others on their binds
  programs.fuse.userAllowOther = true;
}
