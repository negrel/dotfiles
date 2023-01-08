{
  description = "NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";

      # Use same nixpkgs versions
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (similar to Arch Linux AUR)
    nur.url = "github:nix-community/NUR";

    # Hyprland compositor
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, nur, hyprland, ... }@inputs:
    let
      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib { inherit inputs; pkgs = nixpkgs; lib = self; };
      });

      mkPkgs = (system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ nur.overlay hyprland.overlays.default ];
      });

      # Make system config helper function
      mkConfig = nixpkgs: hostname: system:
        let pkgs = (mkPkgs system) // self.packages."${system}";
        in
        # nixosSystem is a nixpkgs function that build a configuration.nix
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Hyprland
            hyprland.nixosModules.default
            # Hostname
            { networking.hostName = hostname; }
            # General configuration
            ./modules/nixos/system/configuration.nix
            # Host specific config
            (./. + "/hosts/${hostname}/configuration.nix")
          ];
          # Extra args to pass to modules
          specialArgs = inputs // { inherit pkgs; };
        };
    in
    {
      nixosConfigurations = {
        matebook = mkConfig nixpkgs "matebook" "x86_64-linux";
      };
      packages = forAllSystems (system:
        let pkgs = mkPkgs system;
        in
        (pkgs.callPackage ./pkgs/aichat { }) //
        (pkgs.callPackage ./pkgs/cli-utils { }) //
        (pkgs.callPackage ./pkgs/gen-theme { }) //
        (pkgs.callPackage ./pkgs/laptop-utils { }) //
        (pkgs.callPackage ./pkgs/dot-profile { }) //
        (pkgs.callPackage ./pkgs/volumectl { }) //
        (pkgs.callPackage ./pkgs/wmctl { }) //
        (pkgs.callPackage ./pkgs/wrapped-hyprland { })
      );
    };

  nixConfig = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
