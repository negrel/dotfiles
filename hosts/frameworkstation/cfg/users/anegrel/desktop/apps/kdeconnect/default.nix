{ pkgs, ... }:

{
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.kdeconnect;

  home-manager.users.anegrel = {
    dot-profile.scripts."99-kdeconnectd".text = ''
      ${pkgs.kdeconnect}/libexec/kdeconnectd &
    '';
  };
}

