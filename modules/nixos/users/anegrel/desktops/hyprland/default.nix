{ home-manager, pkgs, lib, ... }:

{
  imports = [
    ./wayland.nix
  ];

  programs.wrapped-hyprland.enable = true;
  programs.eww.enable = true;

  home-manager.users.anegrel = {
    home.packages = with pkgs; [
      swaybg
      swayidle
    ];

    # Configuration files
    home.file.".config/hypr".source = ./config;

    # Templates
    home.file.".config/gen-theme/templates/hyprland".source = ./templates/hyprland;
  };
}
