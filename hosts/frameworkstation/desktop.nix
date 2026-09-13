{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-shell.enable = true;

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  environment.systemPackages = with pkgs; [
    firefox
    ghostty

    # GNOME
    gnome-calculator
    gnome-calendar
    gnome-font-viewer
    gnome-logs
    nautilus
    snapshot
  ];

  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      jetbrains-mono
      noto-fonts
    ];
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Awaita Sans" ];
        serif = [ "Awaita Sans" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [
          "FontAwesome"
          "Material Design Icons"
          "Noto Color Emoji"
        ];
      };
    };
  };
}
