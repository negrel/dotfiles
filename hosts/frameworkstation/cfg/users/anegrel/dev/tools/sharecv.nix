{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
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
