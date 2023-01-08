{ pkgs, lib, ... }:

with lib;
{
  home.packages = with pkgs; [
    wl-clipboard
    eww-wayland
    mako
    libnotify
    rofi-wayland
    inlyne

    wmctl
  ];

  # Configs
  home.file.".config/gtk-3.0/settings.ini".source = ./configs/gtk/settings.ini;
  home.file.".config/gtk-4.0/settings.ini".source = ./configs/gtk/settings.ini;
  home.file.".config/eww".source = ./configs/eww;
  home.file.".config/profile.d/90-gsettings".source = ./configs/profile.d/90-gsettings;
  home.file.".config/rofi".source = ./configs/rofi;

  # Templates
  home.file.".config/gen-theme/templates/colors.scss".source = ./templates/colors.scss;
  home.file.".config/gen-theme/templates/mako".source = ./templates/mako;
  home.file.".config/gen-theme/templates/rofi".source = ./templates/rofi;

  home.activation.de = hm.dag.entryAfter [ "gen-theme" ] ''
    # $DRY_RUN_CMD mkdir -p ~/.config/mako
    # $DRY_RUN_CMD ln -sf ~/.cache/theme/mako ~/.config/mako/config
  '';
}
