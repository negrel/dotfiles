{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      waybar
    ];

    home.file.".config/waybar/config".source = ./config/config;
    home.file.".config/waybar/style.css".source = ./config/style.css;

    gen-theme.templates."waybar.css" = {
      source = ./templates/waybar.css;
      destination = ".config/waybar/colors.css";
    };
  };
}

