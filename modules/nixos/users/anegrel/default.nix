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
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "wireshark" ];
      hashedPassword = import ./hashedPassword.nix { };
    };
  };

  # Import home manager config
  home-manager.users.anegrel = import ./home.nix;
}
