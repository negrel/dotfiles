{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        dufs
        nodePackages.localtunnel

        # under pkgs/
        my.sharecv
      ];

      zshrc.scripts = {
        "dufs".text = ''
          alias webdavd=dufs
        '';
      };
    };
}
