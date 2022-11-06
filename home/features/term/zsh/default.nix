# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
                        

{ config, pkgs, lib, ... }: 
{
  imports = [ 
    ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";

      history = {
        size = 100000;
        save = 100000;
        share = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "gcloud"
          "gpg-agent"
          "direnv"
          "fzf"
          "grc"
          "golang"
          "sudo"
          "docker"
          "ripgrep"
          "fd"
          "kubectl"
          "helm"
          "terraform"
          "pass"
          "history-substring-search"
        ];
      };

      plugins = [
        {
          name = "zsh-fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];

      profileExtra = builtins.readFile ./profileExtra;
    };
  };
}
