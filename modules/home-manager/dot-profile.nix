{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.dot-profile;

in
{
  options.dot-profile = {
    enable = mkEnableOption { };
    scripts = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ dot-profile ];
      file = lib.mapAttrs'
        (name: value: {
          name = ".config/profile.d/" + name;
          inherit value;
        })
        cfg.scripts;
    };
  };
}
