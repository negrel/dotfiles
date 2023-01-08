{ pkgs, ... }:

rec {
  laptop-utils = pkgs.symlinkJoin rec {
    name = "laptop-utils";
    utils = [ backlight-laptop-util battery-laptop-util ];
    paths = utils;
  };

  backlight-laptop-util = pkgs.writeShellApplication {
    name = "blightctl";
    runtimeInputs = with pkgs; [ bash coreutils light ];
    text = builtins.readFile ./bin/blightctl;
  };

  battery-laptop-util = pkgs.writeShellApplication {
    name = "battery";
    runtimeInputs = with pkgs; [ bash coreutils ];
    text = builtins.readFile ./bin/battery;
  };
}
