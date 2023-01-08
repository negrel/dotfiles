{ pkgs, ... }:

{
  imports = [
    ../wayland
  ];

  home.packages = with pkgs; [
    swaybg
    swayidle
  ];

  # Configs
  home.file.".config/hypr".source = ./config;

  # Templates
  home.file.".config/gen-theme/templates/hyprland".source = ./templates/hyprland;

}
