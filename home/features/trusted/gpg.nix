{ pkgs, config, lib, ... }:
let
  fetchKey = { url, sha256 ? lib.fakeSha256 }:
    builtins.fetchurl { inherit sha256 url; };

  pinentry =
    if config.gtk.enable then {
      package = pkgs.pinentry-gnome;
      name = "gnome3";
    } else {
      package = pkgs.pinentry-curses;
      name = "curses";
    };
in
{
  home.packages = [ pinentry.package ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ config.myconf.gpgid ];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };

  programs =
    let
      fixGpg = ''
        gpgconf --launch gpg-agent
      '';
    in
    {
      # Start gpg-agent if it's not running or tunneled in
      # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
      # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
      zsh.loginExtra = fixGpg;

      gpg = {
        enable = true;
        settings = {
          trust-model = "tofu+pgp";
        };
        publicKeys = [
          {
            # TODO: add to myconf (myuserconf)
            source = fetchKey {
              url = "https://keybase.io/brunoadele/pgp_keys.asc";
              sha256 = "sha256:1hr53gj98cdvk1jrhczzpaz76cp1xnn8aj23mv2idwy8gcwlpwlg";
            };
            trust = 5;
          }
        ];
      };
    };
  home.persistence = {
    "/persist/user".directories = [ ".gnupg" ];
  };

  # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
  # So that SSH config does not have to know the UID
  systemd.user.services.link-gnupg-sockets = {
    Unit = {
      Description = "link gnupg sockets from /run to /home";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
      ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
      RemainAfterExit = true;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
