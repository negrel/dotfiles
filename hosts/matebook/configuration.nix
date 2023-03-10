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

  networking.hostName = "matebook"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager = {
    enable = false; # Easiest to use and most distros use this by default.
    wifi.backend = "iwd";
  };
  # Explicitly disabling it as it conflict with ISO module
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.
  networking.wireless.iwd.enable = true;

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
  services.gnome.gnome-keyring.enable = true;

  # GUI stack
  services = {
    xserver.enable = true;
    xserver.displayManager.gdm = {
      wayland = true;
      enable = true;
    };
    xserver.desktopManager.gnome.enable = true;

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
        monospace = [ "JetBrains Mono" ];
        emoji = [ "FontAwesome" ];
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
