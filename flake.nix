{
  description = "NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";

      # Use same nixpkgs versions
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (similar to Arch Linux AUR)
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, nur, ... }@inputs:
    let
      # Make system config helper function
      mkConfig = system: hostname:
        let
          pkgs = self.pkgs."${system}" // self.packages."${system}";
          lib = self.lib."${system}";
        in
        # nixosSystem is a nixpkgs function that build a configuration.nix
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Hostname
            { networking.hostName = hostname; }
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
          matebook = mkConfig "x86_64-linux" "matebook";
        };
      };
      outputsWithSystem =
        flake-utils.lib.eachDefaultSystem
          (system:
            let
              pkgs = import nixpkgs {
                inherit system;
                config = { allowUnfree = true; };
                overlays = [
                  nur.overlay

                  # Add flake-utils.lib to pkgs.lib.flake-utils
                  (self: super: {
                    lib = super.lib // { flake-utils = flake-utils.lib; };
                  })

                  # Add ./lib to pkgs.lib.my
                  (self: super: {
                    lib = super.lib // { my = import ./lib { inherit (super) lib; }; };
                  })
                ];
              };
            in
            {
              pkgs = pkgs;
              lib = pkgs.lib;
              packages = pkgs.lib.my.callPackagesRecursively ./pkgs { inherit pkgs; };
            });
    in
    outputsWithSystem // outputsWithoutSystem;
}
