{ pkgs, ... }:

{
  imports = [
    ../../wrapped-hyprland.nix
    ../../eww.nix

    ./desktops/common
    ./desktops/gnome
    ./desktops/hyprland
    ./desktops/sway
  ];

  users = {
    users.anegrel = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "wireshark" "adbusers" ];
      hashedPassword = import ./hashedPassword.nix { };
    };
  };
  programs.zsh.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Import home manager config
  home-manager.users.anegrel = import ./home.nix;
}
