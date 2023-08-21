{ home-manager, pkgs, lib, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;

  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}
