{ pkgs, ... }:

{
  programs.wrapped-hyprland.enable = true;
  programs.eww.enable = true;

  # Use lib from home-manager
  home-manager.users.anegrel = { lib, ... }: import ../../programs/wayland { inherit pkgs lib; } // {
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
