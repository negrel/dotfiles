{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        gitFull
        git-lfs
        tig
        gh
        act
      ];

      home.file.".gitconfig".source = ./config;
    };
}
