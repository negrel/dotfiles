{ pkgs, ... }:

{
  users = {
    users.anegrel = {
      extraGroups = [ "adbusers" ];
    };
  };

  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [ android-tools ];
    };

  # Allow non root users to use adb
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
