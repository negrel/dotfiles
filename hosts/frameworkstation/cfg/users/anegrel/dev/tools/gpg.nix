{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        gnupg
        pinentry-curses
      ];
    };
}
