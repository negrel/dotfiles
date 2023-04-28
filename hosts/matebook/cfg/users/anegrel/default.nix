{ pkgs, lib, ... }:

{
  users = {
    users.anegrel = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "wireshark" "adbusers" ];
      hashedPassword = lib.my.readSecret "anegrel.hashedPassword";
    };
  };
  programs.zsh.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Import home manager config
  home-manager.users.anegrel = import ./home-manager { inherit pkgs lib; };
}
