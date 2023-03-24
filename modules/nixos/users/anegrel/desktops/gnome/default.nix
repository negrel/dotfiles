{ pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.pop-shell
  ];

  # Use lib from home-manager
  home-manager.users.anegrel = { lib, ... }: {
    home.packages = with pkgs;
      [
        gnome.gnome-tweaks
      ];

    home.file.".config/profile.d/90-keyboard".source = ./config/profile.d/90-keyboard;
    home.file.".config/profile.d/90-wallpaper".source = ./config/profile.d/90-wallpaper;

    # Templates
    home.file.".config/gen-theme/templates/shell".source = ./templates/shell;
  };
}
