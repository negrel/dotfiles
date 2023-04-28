{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.zshrc;
in
{
  options.zshrc = {
    scripts = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf config.programs.zsh.enable {
    home = {
      file = (lib.mapAttrs'
        (name: value: {
          name = ".config/zsh/rc.d/" + name;
          inherit value;
        })
        cfg.scripts) // {
        ".config/zsh/rc".source = ./config/rc;
      };
    };
  };
}
