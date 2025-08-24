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

    # A wrapper tool for nix OpenGL application.
    nixgl.url = "github:nix-community/nixGL";

    # External packages
    ghostty.url = "github:negrel/ghostty";
    scratch = {
      url = "github:negrel/scratch";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wooz = {
      url = "github:negrel/wooz";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    localtunnel = {
      url = "github:negrel/localtunnel";
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
      nixgl,
      ghostty,
      scratch,
      wooz,
      localtunnel,
      ...
    }@inputs:
    let
      # Overlay for my lib (./lib) my packages (./pkgs) and other inputs.
      lib = nixpkgs.lib // {
        my = import ./lib { lib = nixpkgs.lib; };
      };
      myoverlay = (
        system: final: prev: {
          ghostty = ghostty.packages.${system}.default;
          scratch = scratch.packages.${system}.default;
          wooz = wooz.packages.${system}.default;
          localtunnel = localtunnel.packages.${system}.default;
          my = self.outputs.packages."${system}";
          nixGLIntel = nixgl.outputs.packages."${system}".nixGLIntel;
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
                nixgl.overlay
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
