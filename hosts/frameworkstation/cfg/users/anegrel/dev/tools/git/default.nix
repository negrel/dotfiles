{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      git
      git-lfs
      tig
      gh
      act
    ];

    home.file.".gitconfig".source = ./config;
  };
}
