{ pkgs, lib, ... }:

with lib;
{
  home.packages = with pkgs; [
    alacritty
  ];

  home.file.".config/gen-theme/templates/alacritty.yml".source = ./templates/config.yml;
  home.activation.alacritty = hm.dag.entryAfter [ "gen-theme" ] ''
    $DRY_RUN_CMD mkdir -p ~/.config/alacritty
    $DRY_RUN_CMD ln -sf ~/.cache/theme/alacritty.yml ~/.config/alacritty/alacritty.yml
  '';
}
