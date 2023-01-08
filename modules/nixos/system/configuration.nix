{ config, pkgs, modulesPath, ... }:

{
  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set timezone
  time.timeZone = "Europe/Paris";

  # Language and keyboard layout
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fr";
  };
  services.xserver.layout = "fr";

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Do not touch (see `man configuration.nix`).
  system.stateVersion = "22.11";
}
