build-iso/%:
	nix build .#nixosConfigurations.$().config.system.build.isoImage
