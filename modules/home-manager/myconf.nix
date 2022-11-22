{ lib, config, ... }:

let
  inherit (lib) mkOption types;
in
{

  options.myconf = {
    # Todo move to host myhostconf
    nproc = lib.mkOption {
      type = lib.types.int;
      description = ''
        Nb processor cores
      '';
    };

    # Todo move to user myuserconf
    gpgid = lib.mkOption {
      type = lib.types.str;
      description = ''
        Public GPG key
      '';
    };
  };
}
