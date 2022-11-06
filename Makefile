fmt-all:
	nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt .'

fmt-file:
	nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt ${FILE}'