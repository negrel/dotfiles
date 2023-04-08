{ config, lib, pkgs, modulesPath, home-manager, ... }:

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

    ../../modules/nixos/laptop.nix
    ../../modules/nixos/volumectl.nix

    # Define users
    ../../modules/nixos/users
    ../../modules/nixos/users/anegrel
  ];

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
    xserver.dpi = 96;
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
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "FontAwesome" "Material Design Icons" "Noto Color Emoji" ];
      };
    };
  };

  # Docker
  virtualisation.docker.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
