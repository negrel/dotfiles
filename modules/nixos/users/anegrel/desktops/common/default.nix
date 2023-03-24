{ ... }:

{
  home-manager.users.anegrel = {
    # Configuration files
    home.file.".config/gtk-3.0/settings.ini".source = ./config/gtk/settings.ini;
    home.file.".config/gtk-4.0/settings.ini".source = ./config/gtk/settings.ini;
    home.file.".config/profile.d/90-gsettings".source = ./config/profile.d/90-gsettings;
  };
}
