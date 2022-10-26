# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
#                         

{ config, pkgs, lib, ... }: {

  programs = {
    zoxide.enable = true; # Autojump [CTRL-J]
    nix-index.enable = true;

    fzf = {
      enable = true;
      defaultCommand = "fd --type file --follow --hidden --exclude .git";
      historyWidgetOptions = [ "--sort" "--exact" ];
    };

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
          "asdf"
          "aws"
          "git"
          "gcloud"
          "gpg-agent"
          "direnv"
          "fzf"
          "grc"
          "sudo"
          "docker"
          "ripgrep"
          "fd"
          "kubectl"
          "helm"
          "terraform"
          "pass"
        ];
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
        {
          name = "zsh-fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];

      profileExtra = ''
        setopt no_beep				                                          # no beep
        setopt rm_star_wait                 	                          # wait 10 seconds before running `rm *`
        setopt hist_ignore_dups             	                          # ignore history duplication
        setopt hist_expire_dups_first       	                          # remove oldest duplicate commands from the history first
        setopt hist_ignore_space            	                          # don't save commands beginning with spaces to history
        setopt append_history               	                          # append to the end of the history file
        setopt inc_append_history           	                          # always be saving history (not just when the shell exits)
        setopt no_flowcontrol	            	                            # Disable ^S and ^Q (freeze & resume flowcontro)

        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       # Colored completion (different colors for dirs/files/etc)
        zstyle ':completion:*' rehash true                              # automatically find new executables in path
        # Speed up completions
        mkdir -p "$(dirname ${config.xdg.cacheHome}/zsh/completion-cache)"
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/completion-cache"
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' menu select

        test -d "${config.home.homeDirectory}/.kube" && export KUBECONFIG=$(ls -1 ${config.home.homeDirectory}/.kube/*.yml | tr " " ":") # Kubernetes contexts

        [[ -f ${pkgs.grc}/etc/grc.zsh ]] && source ${pkgs.grc}/etc/grc.zsh
      '';

      sessionVariables = {

        PATH = lib.concatStringsSep ":" [
          "${config.home.homeDirectory}/.local/bin"
          "\${PATH}"
        ];

        TERMINAL = "${pkgs.wezterm}/bin/wezterm";
        EDITOR = "${pkgs.neovim}/bin/nvim";
        LESS = "-FSRXI"; # Less for colors man page

        # Private folderss
        WORK = "${config.home.homeDirectory}/work/projects";
        PRIVATE = "${config.home.homeDirectory}/private/projects";
        PASSWORD_STORE_DIR = "\${PRIVATE}/pass";

        # TODO
        # GNUPGHOME="${config.xdg.configHome}/gnupg";

        # # GPG
        # export SSH_AUTH_SOCK=$(gpgconf –list-dirs agent-ssh-socket)
        # export GPG_USERID=00F421C4C5377BA39820E13F6B95E13DE469CC5D
        # export GPG_BACKUP_DIR=/mnt/usb-black-disk/freefilesync/famille/bruno/home/security/gpg
        # export TELEPORT_USE_LOCAL_SSH_AGENT="false"

        # # AGE
        # export AGE_PUBLIC_KEY="age1xmunmxy9u93gclsc962ctcswawa8w73vqjwe0csykhwth46qpv3qun3657"
        # export AGE_PRIVATE_FILE="~/.age/secret-key.txt"
      };

      shellAliases = {
        nfmt =  "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt .";
        ns = "nix-shell";
        nsp = "nix-shell --pure";
      };
    };
  };
}
