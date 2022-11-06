{ config
, pkgs
, lib
, ... 
}: 
{
    home.sessionVariables = {

    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";

    PATH = lib.concatStringsSep ":" [
        "${config.home.homeDirectory}/.local/bin"
        "\${PATH}"
    ];

    TERMINAL = "${pkgs.wezterm}/bin/wezterm";
    EDITOR = "${pkgs.neovim}/bin/nvim";

    # Private folderss
    WORK = "${config.home.homeDirectory}/work/projects";
    PRIVATE = "${config.home.homeDirectory}/private/projects";
    PASSWORD_STORE_DIR = "${config.home.sessionVariables.PRIVATE}/pass";

    # Colors
    GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36";

    # less & Man color
    LESS_TERMCAP_mb="\$(tput bold; tput setaf 2)"; # green
    LESS_TERMCAP_md="\$(tput bold; tput setaf 6)"; # cyan
    LESS_TERMCAP_me="\$(tput sgr0)";
    LESS_TERMCAP_so="\$(tput bold; tput setaf 3; tput setab 4)"; # yellow on blue
    LESS_TERMCAP_se="\$(tput rmso; tput sgr0)";
    LESS_TERMCAP_us="\$(tput smul; tput bold; tput setaf 4)"; # purple
    LESS_TERMCAP_ue="\$(tput rmul; tput sgr0)";
    LESS_TERMCAP_mr="\$(tput rev)";
    LESS_TERMCAP_mh="\$(tput dim)";
    LESS_TERMCAP_ZN="\$(tput ssubm)";
    LESS_TERMCAP_ZV="\$(tput rsubm)";
    LESS_TERMCAP_ZO="\$(tput ssupm)";
    LESS_TERMCAP_ZW="\$(tput rsupm)";

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
}