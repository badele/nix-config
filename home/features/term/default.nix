# 
# ████████╗███████╗██████╗ ███╗   ███╗
# ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
#    ██║   █████╗  ██████╔╝██╔████╔██║
#    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
#    ██║   ███████╗██║  ██║██║ ╚═╝ ██║
#    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝

{ config
, pkgs
, ...
}: {

  imports = [
    ./broot.nix
    ./starship.nix
    ./user-scripts
    ./zsh.nix
  ];

  # NOTE: By default all programs enabled for the all shells
  programs = {
    # command not found and nix-locate
    nix-index.enable = true;

    # Autojump
    zoxide = {
      enable = true;
      options = [ "--cmd j" ];
    };

    # FZF
    fzf = {
      enable = true;
      enableZshIntegration = false; ## OMZ
      defaultCommand = "fd --type file --follow --hidden --exclude .git";
      historyWidgetOptions = [ "--sort" "--exact" ];
    };

    # Cheats navigators
    navi = {
      enable = true;
      settings = {
        cheats = {
          paths = [
            "~/ghq/github.com/badele/cheats"
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    # Nix
    nix-index # Show the corresponding package must be installed when command not found
    nixpkgs-fmt # Nix formatter
    nix-prefetch-github # Compute SHA256 github repository
    haskellPackages.nix-derivation # Analyse derivation with pretty-derivation < packagename.drv

    awscli
    up
    curl
    wget
    eva

    nvd # Show diff nix packages
    nix-diff # Check derivation differences

    # Editor
    neovim

    # Colors
    pastel ## Colors generator
    grc ## colorize some commands results
    # TODO: Colout with 

    bat # cat alternative
    exa # ls alternative
    fd # find alternative
    httpie # curl alternative

    #    procs # top alternative
    bottom # System viewer
    ripgrep # Better grep
    jq # JSON pretty printer and manipulator
    sops # Deployment secrets tool
  ];

}
