{ 
config
, inputs
, pkgs
, lib
, ... 
}: 
{ 
    imports = [ 
      ./global 
      ./features/term 
    ]; 

  home = {
    username = lib.mkDefault "badele";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
  };

    programs.git = {
      enable = true;
      userName = "Bruno Adelé";
      userEmail = "brunoadele@gmail.com";
      signing = {
        key = "00F421C4C5377BA39820E13F6B95E13DE469CC5D";
        signByDefault = true;
    };

    extraConfig = {
        core.pager="delta";
        interactive.difffilter="delta --color-only --features=interactive";
        delta.side-by-side=true;
        delta.navigate=true;
        merge.conflictstyle="diff3";
    };
  };}
