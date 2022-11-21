{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  programs.wezterm.enable = true;

  home.packages = with pkgs; [
    swaylock # lockscreen
    swayidle # power off
    xwayland # legacy apps
    waybar # wayland polybar alternative
    wl-clipboard # clipboard
    wofi # rofi alternative
    wf-recorder # screen recorder
    mako # notification
    kanshi # wayland autorandr alternative
    imv # Images viewer
    mimeo # mimeo / TODO persist configuration ? /home/badele/.config/mimeapps.list
    pulseaudio
    slurp
    swaylock
    wev
    waypipe
    wl-mirror
    wl-mirror-pick

  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
