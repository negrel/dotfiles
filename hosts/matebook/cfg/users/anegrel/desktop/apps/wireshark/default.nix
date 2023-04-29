{ pkgs, ... }:

{
  users.users.anegrel = {
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
