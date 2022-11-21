{
  # Adds my custom packages
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # My wallpapers
  wallpapers = final: prev: {
    wallpapers = final.callPackage ../pkgs/wallpapers { };
  };

  # Modifies existing packages
  modifications = final: prev: {
    # Fixes https://todo.sr.ht/~scoopta/wofi/174
    wofi = prev.wofi.overrideAttrs (oldAttrs: rec {
      patches = (oldAttrs.patches or [ ]) ++ [ ./wofi-run-shell.patch ];
    });


    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
