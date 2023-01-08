{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.eww;

in
{
  options.programs.eww = {
    enable = mkEnableOption { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eww-wayland
    ];
  };
}
