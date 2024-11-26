{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [ waybar ];

    home.file.".config/waybar/config".source = ./config/config.json;

    gen-theme.templates."waybar.css" = {
      source = ./templates/style.css;
      destination = ".config/waybar/style.css";
    };
  };
}

