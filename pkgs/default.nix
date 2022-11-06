{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs { }
, lib ? pkgs.lib
}: {

  colout = pkgs.python3Packages.callPackage ./colout.nix { };
}
