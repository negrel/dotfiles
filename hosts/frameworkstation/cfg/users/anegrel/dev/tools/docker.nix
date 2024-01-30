{ pkgs, lib, ... }:

{
  users = {
    users.anegrel = {
      extraGroups = [ "docker" ];
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  home-manager.users.anegrel = { ... }: {
    home.file.".docker/config.json".text = lib.my.readSecret "negrel.docker.config.json";
    home.packages = with pkgs; [
      dive
      buildah
    ];
  };
}
