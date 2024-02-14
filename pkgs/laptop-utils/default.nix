{ pkgs, ... }:

let
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

  battery-notification = pkgs.writeShellApplication {
    name = "battery_notification";
    runtimeInputs = with pkgs; [ bash coreutils libnotify battery-laptop-util sudo ];
    text = builtins.readFile ./bin/battery_notification;
  };
in
pkgs.symlinkJoin rec {
  name = "laptop-utils";
  utils = [ backlight-laptop-util battery-laptop-util battery-notification ];
  paths = utils;
}
