{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:badele/fork-nixos-hardware/dell-e5540";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib) filterAttrs traceVal;
      inherit (builtins) mapAttrs elem;
      inherit (self) outputs;
      notBroken = x: !(x.meta.broken or false);
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      templates = import ./templates;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays;

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = with overlays; [ additions wallpapers modifications ];
          config.allowUnfree = true;
        }
      );

      packages = forAllSystems
        (system: import ./pkgs { pkgs = legacyPackages.${system}; });

      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });

      ########################################################################
      # System
      ########################################################################
      nixosConfigurations = rec {
        # # Nixbox
        # nixbox = nixpkgs.lib.nixosSystem {
        #   pkgs = legacyPackages."x86_64-linux";
        #   specialArgs = { inherit inputs outputs; };
        #   modules = [ ./hosts/nixbox ];
        # };

        # Latitude E5540
        latino = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/latino ];
        };

        # Netbook
        # samba = nixpkgs.lib.nixosSystem {
        #   pkgs = legacyPackages."x86_64-linux";
        #   specialArgs = { inherit inputs outputs; };
        #   modules = [ ./hosts/sam ];
        # };
      };

      ########################################################################
      # User
      ########################################################################
      homeConfigurations = {
        # Nixbox
        "vagrant_on_nixbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/vagrant.nix ];
        };

        "badele_on_latino" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/badele.nix ];
        };

        "root_on_latino" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/root.nix ];
        };


        # Netbook
        # "badele_on_sam" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = legacyPackages."x86_64-linux";
        #   extraSpecialArgs = { inherit inputs outputs; };
        #   modules = [ ./home/badele.nix ];
        # };
      };

      nixConfig = {
        extra-substituers = [ "https://nix-community.cachix.org" ];
        extra-trusted-public-keys =
          [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      };
    };
}
