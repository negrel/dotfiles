{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      git
      tig
      gh
      act
    ];

    home.file.".gitconfig".source = ./config;
  };
}
