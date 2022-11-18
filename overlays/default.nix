{
  # Adds my custom packages
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # My wallpapers
  wallpapers = final: prev: {
    wallpapers = final.callPackage ../pkgs/wallpapers { };
  };

  # Modifies existing packages
  modifications = final: prev: {
    vimPlugins = prev.vimPlugins // {
      vim-numbertoggle = prev.vimPlugins.vim-numbertoggle.overrideAttrs
        (oldAttrs: rec {
          patches = (oldAttrs.patches or [ ])
            ++ [ ./vim-numbertoggle-command-mode.patch ];
        });
      nvim-treesitter = prev.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          ./nvim-treesitter-nix-injection.patch
        ];
      });
    } // final.callPackage ../pkgs/vim-plugins { };

    tree-sitter-grammars = prev.tree-sitter-grammars // {
      tree-sitter-nix = prev.tree-sitter-grammars.tree-sitter-nix.overrideAttrs (oldAttrs: {
        src = final.fetchFromGitHub {
          owner = "cstrahan";
          repo = "tree-sitter-nix";
          rev = "1b69cf1fa92366eefbe6863c184e5d2ece5f187d";
          sha256 = "sha256-JaJRikijCXnKAuKA445IIDaRvPzGhLFM29KudaFsSVM=";
        };
      });
    };

    xdg-utils-spawn-terminal = prev.xdg-utils.overrideAttrs (oldAttrs: rec {
      patches = (oldAttrs.patches or [ ]) ++ [ ./xdg-open-spawn-terminal.diff ];
    });

    # Fixes https://todo.sr.ht/~scoopta/wofi/174
    wofi = prev.wofi.overrideAttrs (oldAttrs: rec {
      patches = (oldAttrs.patches or [ ]) ++ [ ./wofi-run-shell.patch ];
    });


    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
