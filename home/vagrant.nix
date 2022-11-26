{ inputs
, pkgs
, ...
}:
{
  imports = [
    ./global
    ./features/term
  ];

  programs.git = {
    enable = true;
    userName = "Bruno Adelé";
    userEmail = "brunoadele@gmail.com";
    signing = {
      key = "00F421C4C5377BA39820E13F6B95E13DE469CC5D";
      signByDefault = true;
    };
    extraConfig = {
      core.pager = "delta";
      interactive.difffilter = "delta --color-only --features=interactive";
      delta.side-by-side = true;
      delta.navigate = true;
      merge.conflictstyle = "diff3";
    };
  };
}
