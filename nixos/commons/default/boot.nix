{ lib, pkgs, inputs, outputs, ... }: {
  imports = [
  ];

  boot.loader.systemd-boot.configurationLimit = 20;

  security.pam.services = { swaylock = { }; };
}
