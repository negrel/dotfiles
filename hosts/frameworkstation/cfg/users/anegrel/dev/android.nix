{ pkgs, ... }:

{
  users = {
    users.anegrel = {
      extraGroups = [ "adbusers" ];
    };
  };

  # Allow non root users to use adb
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
