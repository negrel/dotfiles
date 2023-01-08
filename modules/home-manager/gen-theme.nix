{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.gen-theme;

in
{
  options.programs.gen-theme = {
    enable = mkEnableOption { };
    theme = mkOption {
      type = types.str;
      default = "moon";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ gen-theme ];
      file.".config/gen-theme/colorschemes/".source = "${pkgs.gen-theme}/etc/gen-theme/colorschemes";
      file.".config/gen-theme/wallpapers/".source = "${pkgs.gen-theme}/etc/gen-theme/wallpapers";
      activation.gen-theme = hm.dag.entryAfter [ "reloadSystemd" "writeBoundary" ] ''
        $DRY_RUN_CMD ${pkgs.gen-theme}/bin/gen-theme ${cfg.theme}
      '';
    };
  };
}
