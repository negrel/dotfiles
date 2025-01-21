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

    ghostty = {
      url = "github:negrel/ghostty";
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
    wooz = {
      url = "github:negrel/wooz";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nur,
      ghostty,
      scratch,
      allelua,
      wooz,
      ...
    }@inputs:
    let
      # Overlay for my lib (./lib) my packages (./pkgs) and other inputs.
      lib = nixpkgs.lib // {
        my = import ./lib { lib = nixpkgs.lib; };
      };
      myoverlay = (
        system: final: prev: {
          scratch = scratch.packages.${system}.default;
          allelua = allelua.packages.${system}.default;
          wooz = wooz.packages.${system}.default;
          my = self.outputs.packages."${system}";
          lib = lib;
        }
      );

      # Make system config helper function
      mkConfig =
        system: hostname:
        # nixosSystem is a nixpkgs function that build a configuration.nix
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Nixpkgs overlays
            {
              nixpkgs.overlays = [
                nur.overlays.default
                ghostty.overlays.default
                (myoverlay system)
              ];
            }

            # Hostname
            {
              networking.hostName = hostname;
            }
            # General configuration
            ./hosts/.common/configuration.nix
            # Host specific config
            (./. + "/hosts/${hostname}/configuration.nix")
          ];

          specialArgs = inputs // {
            inherit lib;
          };
        };
      outputsWithoutSystem = {
        nixosConfigurations = {
          frameworkstation = mkConfig "x86_64-linux" "frameworkstation";
        };
      };
      outputsWithSystem = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };
            overlays = [
              nur.overlays.default
              (myoverlay system)
            ];
          };
        in
        {
          pkgs = pkgs;
          lib = lib;
          packages = lib.my.callPackagesRecursively ./pkgs { inherit pkgs; };
        }
      );
    in
    outputsWithSystem // outputsWithoutSystem;
}
