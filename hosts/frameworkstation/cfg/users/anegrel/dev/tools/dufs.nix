{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      dufs
    ];

    zshrc.scripts = {
      "dufs".text = ''
        alias webdavd=dufs
      '';
    };
  };
}
