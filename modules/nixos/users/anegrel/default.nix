{ pkgs, ... }:

{
  imports = [
    ../../wrapped-hyprland.nix
    ../../eww.nix
  ];

  users = {
    users.anegrel = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "wireshark" ];
      hashedPassword = import ./hashedPassword.nix { };
    };
  };

  programs.sway.enable = true;
  programs.wrapped-hyprland.enable = true;
  programs.eww.enable = true;

  # Import home manager config
  home-manager.users.anegrel = import ./home.nix;
}
