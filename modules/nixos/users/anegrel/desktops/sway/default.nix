{ pkgs, ... }:

{
  programs.sway.enable = true;
  programs.eww.enable = true;

  home-manager.users.anegrel = { lib, ... }: import ../../programs/wayland { inherit pkgs lib; } // {
    home.packages = with pkgs; [
      sway
      swaylock
      swaybg
      waybar
      gen-theme
    ];

    # Configuration files
    home.file.".config/sway".source = ./config/sway;
    home.file.".config/waybar".source = ./config/waybar;

    # Templates
    home.file.".config/gen-theme/templates/sway".source = ./templates/sway;
    home.file.".config/gen-theme/templates/swaylock".source = ./templates/swaylock;
    home.file.".config/gen-theme/templates/waybar".source = ./templates/waybar;
    home.activation.de = lib.hm.dag.entryAfter [ "gen-theme" ] ''
      $DRY_RUN_CMD mkdir -p ~/.config/swaylock
      $DRY_RUN_CMD ln -sf ~/.cache/theme/swaylock ~/.config/swaylock/config
    '';
  };
}
