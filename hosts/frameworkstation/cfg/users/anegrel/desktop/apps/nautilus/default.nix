{ pkgs, ... }:

{
  services.gvfs.enable = true;
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      nautilus
      # Exec Terminal=True .desktop file with the right terminal emulator
      xdg-terminal-exec
    ];
  };
}

