{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    glib.bin
    gnome.gnome-settings-daemon
    gsettings-desktop-schemas
  ];

  home-manager.users.anegrel = {
    # Configuration files
    home.file.".config/gtk-3.0/settings.ini".source = ./config/gtk/settings.ini;
    home.file.".config/gtk-4.0/settings.ini".source = ./config/gtk/settings.ini;

    dot-profile.scripts."gsettings".text = ''
      gnome_schema="org.gnome.desktop.interface"
      gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
      icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
      cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
      font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
      gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
      gsettings set "$gnome_schema" icon-theme "$icon_theme"
      gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
      gsettings set "$gnome_schema" font-name "$font_name"
    '';
  };
}
