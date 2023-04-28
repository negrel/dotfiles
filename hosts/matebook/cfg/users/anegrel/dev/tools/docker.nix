{ pkgs, ... }:

{
  users = {
    users.anegrel = {
      extraGroups = [ "docker" ];
    };
  };

  virtualisation.docker.enable = true;

  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      dive
    ];
  };
}
