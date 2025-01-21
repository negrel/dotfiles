{
  lib,
  home-manager,
  ...
}:

{
  imports =
    [
      ./hardware-configuration.nix

      # Home manager
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }
    ]
    # Import files under cfg/ except home/ files
    ++ builtins.filter (filepath: !lib.hasInfix "home-manager" (builtins.toString filepath)) (
      lib.my.buildImportListFrom ./cfg
    )
    # Custom modules
    ++ lib.my.buildImportListFrom ../../modules/nixos;
}
