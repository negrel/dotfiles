{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.system.laptop;

in
{
  options.system.laptop = {
    isLaptop = mkEnableOption { };
    devPath = mkOption {
      default = "/sys/class/backlight/amdgpu_bl1";
    };
  };

  config = mkIf cfg.isLaptop {
    environment.systemPackages = with pkgs; [
      laptop-utils
      lm_sensors
      powertop
    ];

    # Users in group video can change backlight
    services.udev.extraRules = ''
      # Users part of video group can change brightness
      ACTION=="add", \
      SUBSYSTEM=="backlight", \
      RUN+="${pkgs.coreutils}/bin/chgrp video ${cfg.devPath}/brightness", \
      RUN+="${pkgs.coreutils}/bin/chmod g+w ${cfg.devPath}/brightness"

      # Battery notification
      SUBSYSTEM=="power_supply", \
      ATTR{status}=="Discharging", \
      ATTR{capacity}=="[0-9]", \
      RUN+="${pkgs.laptop-utils}/bin/battery_notification"
    '';
  };
}
