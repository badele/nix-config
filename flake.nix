{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });

      packages = forAllSystems
        (system: import ./pkgs { pkgs = legacyPackages.${system}; });

      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });

      ########################################################################
      # System
      ########################################################################
      nixosConfigurations = rec {
        # Nixbox
        nixbox = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./system/hosts/nixbox ];
        };

        # Netbook
        sam = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./system/hosts/sam ];
        };
      };

      ########################################################################
      # User
      ########################################################################
      homeConfigurations = {
        # Nixbox
        "vagrant@nixbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/vagrant.nix ];
        };

        # Netbook
        # "badele@sam" = home-manager.lib.homeManagerConfiguration {
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
