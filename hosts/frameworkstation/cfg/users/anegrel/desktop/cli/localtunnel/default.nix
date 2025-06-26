{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        localtunnel
      ];
    };
}
