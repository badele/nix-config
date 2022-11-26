{ config
, pkgs
, ...
}:

{
  imports = [
    ./autologin.nix
    ./backup.nix
    ./boot.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./security.nix
    ./sops.nix
  ];

  environment.systemPackages = with pkgs; [
  ];

  enableAllTerminfo = true;
  virtualisation.docker.enable = true;

  environment = {
    loginShellInit = ''
      # Activate home-manager environment, if not already
      [ -d "~/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
    '';
  };

}
