# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.hardware.nixosModules.dell-latitude-5520
      ./hardware-configuration.nix
      ../../commons/default
      ../../commons/optional/audio.nix
      #      ../wm/plasma

      # Users
      ../../users/root.nix
      ../../users/badele.nix
    ];

  programs = {
    dconf.enable = true;
  };

  services.dbus.packages = [ pkgs.gcr ];

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    opentabletdriver.enable = true;
  };

  programs.light.enable = true;

  # services.logind = {
  #   lidSwitch = "suspend";
  #   lidSwitchExternalPower = "lock";
  # };


  nixpkgs.config.unfree = true;
  system.stateVersion = "22.05";
}

