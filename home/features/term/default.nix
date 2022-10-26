# 
# ████████╗███████╗██████╗ ███╗   ███╗
# ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
#    ██║   █████╗  ██████╔╝██╔████╔██║
#    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
#    ██║   ███████╗██║  ██║██║ ╚═╝ ██║
#    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝

{ 
pkgs
, config
, ... 
}: {

  imports = [ ./zsh ];

  home.packages = with pkgs; [
    # Nix
    nix-index # Show the corresponding package must be installed when command not found
    nixpkgs-fmt # Nix formatter
    nix-prefetch-github # Compute SHA256 github repository
    haskellPackages.nix-derivation # Analyse derivation with pretty-derivation

    nvd # Show diff nix packages
    nix-diff # Check derivation differences

    # Editor
    neovim

    # Colors
    pastel ## Colors generator
    grc ## colorize some commands results
    # TODO: Colout with 

    bc # Calculator
    bottom # System viewer
    exa # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    sops # Deployment secrets tool

    # Dev
    asdf-vm
  ];
}
