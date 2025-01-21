{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  config = mkIf config.services.pipewire.enable {
    environment.systemPackages = with pkgs; [
      my.volumectl
    ];
  };
}
