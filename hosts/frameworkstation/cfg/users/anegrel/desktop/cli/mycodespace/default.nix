{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        my.mycodespace
      ];

      dot-profile.scripts.".config/profile.d/00-sish-hostname".text = ''
        export SISH_HOSTNAME="tunnel.negrel.dev"
      '';
    };
}
