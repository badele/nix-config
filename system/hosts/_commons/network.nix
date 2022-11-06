{ inputs, outputs, lib, config, ... }:
{

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

 networking.networkmanager.enable = true;  

  environment.persistence."/persist/host" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };

}