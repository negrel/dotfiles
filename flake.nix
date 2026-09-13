{
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations = {
      frameworkstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/frameworkstation
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };
    devShells = {
      x86_64-linux =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ nixfmt-tree ];
          };
        };
    };
  };
}
