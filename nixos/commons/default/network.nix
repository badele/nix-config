{ inputs, outputs, lib, config, ... }:
{

  imports = [
  ];

  networking.domain = "adele.local";

  networking.networkmanager.enable = true;

  environment.persistence."/persist/host" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };

}
