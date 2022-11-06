# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.hardware.nixosModules.dell-latitude-5520

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../_commons

      # Users
      ../_users/root.nix
      ../_users/badele.nix
    ];

  nixpkgs.config.unfree = true;
  system.stateVersion = "22.05";
}

