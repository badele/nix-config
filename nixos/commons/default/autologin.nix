{ pkgs, inputs, lib, config, ... }:
{
  # https://gist.github.com/caadar/7884b1bf16cb1fc2c7cde33d329ae37f
  systemd.services."autologin@tty1".description = "Autologin at the TTY1";
  systemd.services."autologin@tty1".after = [ "systemd-logind.service" ]; # without it user session not started and xorg can't be run from this tty
  systemd.services."autologin@tty1".wantedBy = [ "multi-user.target" ];
  systemd.services."autologin@tty1".serviceConfig =
    {
      ExecStart = [
        "" # override upstream default with an empty ExecStart
        "@${pkgs.utillinux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login --autologin badele --noclear %I $TERM"
      ];
      Restart = "always";
      Type = "idle";
    };
}
