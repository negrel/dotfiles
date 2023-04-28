{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      mako
      libnotify
    ];

    gen-theme.templates."mako" = {
      source = ./templates/mako;
      destination = ".config/mako/config";
    };
  };
}

