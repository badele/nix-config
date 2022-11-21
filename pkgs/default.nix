{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs { }
, lib ? pkgs.lib
}: {

  colout = pkgs.python3Packages.callPackage ./colout.nix { };

  # Packages with an actual source
  swayfader = pkgs.callPackage ./swayfader { };

  # Personal scripts
  pass-wofi = pkgs.callPackage ./pass-wofi { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
}
