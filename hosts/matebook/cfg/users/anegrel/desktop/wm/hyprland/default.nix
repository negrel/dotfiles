{ home-manager, pkgs, lib, ... }:

{
  programs.hyprland-wrapped.enable = true;

  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      swaybg
      swaylock
      swayidle

      # CLI utils
      screenshot
      wmctl
    ];

    # Configuration files
    home.file.".config/hypr".source = ./config/hypr;

    # Templates
    gen-theme.templates."hyprland".source = ./templates/hyprland;
    gen-theme.templates."swaylock" = {
      source = ./templates/swaylock;
      destination = ".config/swaylock/config";
    };
  };
}
