# nix-config

```
nix-shell
sudo nixos-rebuild build --flake .#nixbox
home-manager build --flake .#vagrant@nixbox
nix build #.packagename