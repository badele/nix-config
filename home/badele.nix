{ config
, inputs
, pkgs
, lib
, ...
}:
{
  imports = [
    ./global
    ./features/term
    ./features/trusted
    ./features/python
    ./features/desktop/commons
    ./features/desktop/wayland
    ./features/desktop/wayland/hyprland
  ];

  home = {
    username = lib.mkDefault "badele";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
  };

  programs.git = {
    enable = true;
    userName = "Bruno Adelé";
    userEmail = "brunoadele@gmail.com";
    signing = {
      key = "00F421C4C5377BA39820E13F6B95E13DE469CC5D";
      signByDefault = true;
    };

    extraConfig = {
      core.pager = "delta";
      interactive.difffilter = "delta --color-only --features=interactive";
      delta.side-by-side = true;
      delta.navigate = true;
      merge.conflictstyle = "diff3";
    };
  };

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = "1";
    }
  ];

  colorscheme = inputs.nix-colors.colorSchemes.summerfruit-dark;

  # https://imgur.com/a/bXDPRpV
  wallpaper = pkgs.wallpapers.snow-purple-white;
  # !! forest-deer-landscape
  # NO blue-orange-abstract
  # NO ocean-sunset
  # NO clouds-moon-painting-purple
  # ?? beach-light-blue
  # NO cubist-purple-pink
  # !! desert-dunes
  # NO desert-dunes-night
  # ?? lowpoly-island
  # NO landscape-forest-elk-purple
  # ?? tree-snow-minimal-white
  # NO city-pink-gold-sunset
  # NO ocean-sunset
  # NO pink-purple-sunset
  # ?? aenami-a-quiet-mind
  # ?? aenami-guiding-light
  # ?? aenami-landscape
  # ?? aenami-serenity
  # ?? landscape-snow-white-pink
  # ?? plains-flowers-green-red
  # !! cubist-crystal-brown-teal
  # NO cubist-orange-blue
  # !! cubist-pink-yellow
  # !!lowpoly-fish
  # painting-river-snow-forest-gold
  # !! snow-purple-white

}



