{ lib, pkgs, inputs, outputs, ... }: {
  imports = [
  ];

  security.sudo.wheelNeedsPassword = false;
  security.pam.services = { swaylock = { }; };
  programs.fuse.userAllowOther = true;
}
