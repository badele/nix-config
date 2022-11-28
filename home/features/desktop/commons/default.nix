{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    unzip
    vscode

  ];
}
