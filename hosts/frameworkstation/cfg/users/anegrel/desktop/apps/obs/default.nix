{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [ my.obs-studio-plugins.advanced-masks ];
  };
}
