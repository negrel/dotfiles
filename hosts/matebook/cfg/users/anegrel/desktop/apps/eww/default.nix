{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [ eww-wayland ];

    home.file.".config/eww".source = ./config;
    gen-theme.templates."colors.scss".source = ./templates/colors.scss;
    gen-theme.templates."colors.mjs".source = ./templates/colors.mjs;
  };
}
