{ pkgs, ... }:
{
  home.packages =
    let
      pythonEnv = pkgs.python310.withPackages (p: with p; [
        pip
        requests
      ]);
    in
    [
      pythonEnv
    ];

}
