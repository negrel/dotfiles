{ ... }:

{
  services.flatpak.enable = true;

  home-manager.users.anegrel = { ... }: {
    dot-profile.scripts."00-flatpak".text = ''
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '';
  };
}
