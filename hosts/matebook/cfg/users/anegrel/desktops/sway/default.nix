{ pkgs, home-manager, ... }:

with home-manager.lib;
{
  programs.sway.enable = true;
  programs.eww.enable = true;

  home-manager.users.anegrel = {
    home.packages = with pkgs; [
      sway
      swaylock
      swaybg
      waybar
      gen-theme
    ];

    # Configuration files
    home.file.".config/sway".source = ./config/sway;
    home.file.".config/waybar".source = ./config/waybar;

    # Templates
    home.file.".config/gen-theme/templates/sway".source = ./templates/sway;
    home.file.".config/gen-theme/templates/waybar".source = ./templates/waybar;
  };
}
