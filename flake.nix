{
  description = "NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";

      # Use same nixpkgs versions
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (similar to Arch Linux AUR)
    nur.url = "github:nix-community/NUR";

    # Nix index
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # External packages
    scratch = {
      url = "github:negrel/scratch";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    allelua = {
      url = "github:negrel/allelua";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, nur, scratch, allelua, ... }@inputs:
    let
      # Make system config helper function
      mkConfig = system: hostname:
        let
          pkgs = (lib.recursiveUpdate self.pkgs."${system}"
            self.packages."${system}") // {
              scratch = scratch.packages.${system}.default;
              allelua = allelua.packages.${system}.default;
            };
          lib = self.lib."${system}";
          # nixosSystem is a nixpkgs function that build a configuration.nix
        in nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Hostname
            {
              networking.hostName = hostname;
            }
            # General configuration
            ./hosts/.common/configuration.nix
            # Host specific config
            (./. + "/hosts/${hostname}/configuration.nix")
          ];
          # Extra args to pass to modules
          specialArgs = inputs // { inherit pkgs lib; };
        };

      outputsWithoutSystem = {
        nixosConfigurations = {
          frameworkstation = mkConfig "x86_64-linux" "frameworkstation";
        };
      };
      outputsWithSystem = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; };
            overlays = [
              nur.overlay

              # Add flake-utils.lib as pkgs.lib.flake-utils
              (self: super: {
                lib = super.lib // { flake-utils = flake-utils.lib; };
              })

              # Add ./lib to pkgs.lib.my
              (self: super: {
                lib = super.lib // {
                  my = import ./lib { inherit (super) lib; };
                };
              })
            ];
          };
        in {
          pkgs = pkgs;
          lib = pkgs.lib;
          packages =
            pkgs.lib.my.callPackagesRecursively ./pkgs { inherit pkgs; };
        });
    in outputsWithSystem // outputsWithoutSystem;
}
