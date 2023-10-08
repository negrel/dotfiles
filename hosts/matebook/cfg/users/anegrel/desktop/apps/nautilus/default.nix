{ pkgs, ... }:

{
  services.gvfs.enable = true;
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      gnome.nautilus
    ];
  };
}

