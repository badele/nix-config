{ lib, config, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.myconf = {
    nproc = lib.mkOption {
      type = lib.types.int;
      description = ''
        Nb processor cores
      '';
    };
  };
}
