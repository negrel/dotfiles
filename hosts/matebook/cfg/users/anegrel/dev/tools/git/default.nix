{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      git
      tig
    ];

    home.file.".gitconfig".source = ./config;
  };
}
