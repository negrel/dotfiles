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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
