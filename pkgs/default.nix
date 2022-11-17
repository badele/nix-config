{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs { }
, lib ? pkgs.lib
}: {

  colout = pkgs.python3Packages.callPackage ./colout.nix { };

  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord { };
  swayfader = pkgs.callPackage ./swayfader { };

  # Personal scripts
  pass-wofi = pkgs.callPackage ./pass-wofi { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
}
