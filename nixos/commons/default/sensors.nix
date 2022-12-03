{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    lm_sensors
  ];

  environment.persistence."/persist/host" = {
    # hideMounts = true;
    directories = [
      "/etc/sysconfig/lm_sensors"
    ];
  };
}
