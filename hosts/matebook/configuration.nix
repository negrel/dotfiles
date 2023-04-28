{ config, lib, pkgs, home-manager, ... }:

{
  imports = [
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
  ++ builtins.filter (filepath: ! lib.hasInfix "home-manager" (builtins.toString filepath)) (lib.my.buildImportListFrom ./cfg)
  # Custom modules
  ++ lib.my.buildImportListFrom ../../modules/nixos;

  # Laptop specific module
  system.laptop.isLaptop = true;

  # Enable fstrimming
  services.fstrim.enable = true;

  # Pick only one of the below networking options.
  networking.networkmanager = {
    enable = true; # Easiest to use and most distros use this by default.
  };
  # Explicitly disabling it as it conflict with ISO module
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  # Hacking
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # Weekly garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 8d";

  # Keyring
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.swaylock.enableGnomeKeyring = true;

  # GUI stack
  services = {
    xserver.enable = true;
    xserver.displayManager.gdm = {
      wayland = true;
      enable = true;
    };
  };
  programs.xwayland.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono" ];
        emoji = [ "FontAwesome" "Material Design Icons" "Noto Color Emoji" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
