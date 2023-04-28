{ pkgs, lib, ... }:

with lib;
{
  home.packages = with pkgs; [
    wl-clipboard
    mako
    libnotify
    rofi-wayland
    inlyne

    wmctl
  ];

  # Configuration files
  home.file.".config/eww".source = ./config/eww;
  home.file.".config/rofi".source = ./config/rofi;

  # Templates
  home.file.".config/gen-theme/templates/colors.scss".source = ./templates/colors.scss;
  home.file.".config/gen-theme/templates/mako".source = ./templates/mako;
  home.file.".config/gen-theme/templates/rofi".source = ./templates/rofi;

  home.activation.de = hm.dag.entryAfter [ "gen-theme" ] ''
    # $DRY_RUN_CMD mkdir -p ~/.config/mako
    # $DRY_RUN_CMD ln -sf ~/.cache/theme/mako ~/.config/mako/config
  '';
}
