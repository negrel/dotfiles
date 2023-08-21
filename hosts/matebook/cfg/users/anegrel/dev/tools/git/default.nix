{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      git
      tig
      gh
    ];

    home.file.".gitconfig".source = ./config;
  };
}
