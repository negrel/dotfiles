{ pkgs, lib, ... }:

with lib;
{
  imports = [
    ../wayland
  ];

  home.packages = with pkgs; [
    sway
    swaylock
    swaybg
    waybar
    gen-theme
  ];

  # Configs
  home.file.".config/sway".source = ./configs/sway;
  home.file.".config/waybar".source = ./configs/waybar;

  # Templates
  home.file.".config/gen-theme/templates/sway".source = ./templates/sway;
  home.file.".config/gen-theme/templates/swaylock".source = ./templates/swaylock;
  home.file.".config/gen-theme/templates/waybar".source = ./templates/waybar;
  home.activation.de = hm.dag.entryAfter [ "gen-theme" ] ''
    $DRY_RUN_CMD mkdir -p ~/.config/swaylock
    $DRY_RUN_CMD ln -sf ~/.cache/theme/swaylock ~/.config/swaylock/config
  '';
}
