{ pkgs, ... }:

{
  services = {
    # Wayland
    xserver.enable = true;

    # Gnome keyring
    gnome.gnome-keyring.enable = true;
  };
  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    # Wayland utils
    wl-clipboard

    # gsettings
    glib.bin
    gsettings-desktop-schemas

    # Theming
    gnome.adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
  ];
  # gsettings
  programs.dconf.enable = true;

  # QT apps theming
  qt = {
    enable = true;
    style = "adwaita";
    platformTheme = "gnome";
  };

  home-manager.users.anegrel = {
    # Configuration files
    home.file.".config/gtk-3.0/settings.ini".source = ./config/gtk/settings.ini;
    home.file.".config/gtk-4.0/settings.ini".source = ./config/gtk/settings.ini;

    # Add desktop schemas in XDG_DATA_DIRS so gsettings can find them.
    dot-profile.scripts."00-gsettings-desktop-schemas".text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      '';

    dot-profile.scripts."gsettings".text = ''
      config="''${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
      if [ ! -f "$config" ]; then exit 1; fi

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
