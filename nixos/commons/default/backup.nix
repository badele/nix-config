{ config, pkgs, ... }:
let
  borgRepos = "/data/borg";
  repoPersist = "${borgRepos}/persist";

  needroot = ''
    if [ "$EUID" -ne 0 ]
        then echo "Please run as root"
        exit 1
    fi
  '';

  my-persist-backup = pkgs.writeShellScriptBin "my-persist-backup" ''
    $needroot
    systemctl restart borgbackup-job-persist
  '';

  my-persist-restore = pkgs.writeShellScriptBin "my-persist-restore" ''
    $needroot
    borg list ${repoPersist}
  '';

  # Create packages with shell scripts
  my-backup-pesist = pkgs.stdenv.mkDerivation rec{
    name = "my-backup-pesist";

    phases = "installPhase fixupPhase";
    buildInputs = [ my-persist-backup my-persist-restore ];
    installPhase = ''
      install -Dm 0755 ${my-persist-backup}/bin//my-persist-backup $out/bin/my-persist-backup    
      install -Dm 0755 ${my-persist-restore}/bin//my-persist-restore $out/bin/my-persist-restore    
    '';
  };
in
{
  # systemctl restart borgbackup-job-persist.
  services.borgbackup.jobs.persist = {
    paths = [
      "/persist"
    ];
    exclude = [
    ];
    extraCreateArgs = "--stats";
    encryption = {
      mode = "repokey";
      passCommand = "cat ${config.sops.secrets."borgbackup/password".path}";
    };
    repo = repoPersist;
    compression = "auto,zstd";
    doInit = true;
    startAt = "daily";
    persistentTimer = true; # run next reboot (if cannot running today)
    prune.keep = {
      last = 1;
      within = "3d";
      daily = 7;
      weekly = 4;
      monthly = 6;
      yearly = 2;
    };
  };

  sops.secrets."borgbackup/password" = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  environment.systemPackages = [
    my-backup-pesist
  ];
}
