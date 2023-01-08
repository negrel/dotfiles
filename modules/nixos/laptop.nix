{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.system.laptop;

in
{
  options.system.laptop = {
    isLaptop = mkEnableOption { };
    devPath = mkOption {
      default = "/sys/class/backlight/intel_backlight";
    };
  };

  config = mkIf cfg.isLaptop {
    environment.systemPackages = with pkgs; [
      tlp
      laptop-utils
      lm_sensors
    ];

    # Users in group video can change backlight
    services.udev.extraRules = ''
      # Users part of video group can change brightness
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video ${cfg.devPath}/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w ${cfg.devPath}/brightness"
    '';
  };
}
