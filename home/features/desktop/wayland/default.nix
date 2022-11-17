{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./mako.nix
    ./qutebrowser.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  programs.wezterm.enable = true;

  home.packages = with pkgs; [
    grim
    imv
    mimeo
    primary-xwayland
    pulseaudio
    slurp
    swaylock
    wev
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    wl-mirror-pick

  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
