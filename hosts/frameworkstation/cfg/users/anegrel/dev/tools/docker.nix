{ pkgs, lib, ... }:

{
  users = {
    users.anegrel = {
      extraGroups = [ "docker" ];
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    daemon.settings = {
      ipv6 = true;
      experimental = true;
      ip6tables = true;
    };
  };

  home-manager.users.anegrel = { ... }: {
    home.file.".docker/config.json".text = lib.my.readSecret "negrel.docker.config.json";
    home.packages = with pkgs; [
      dive
      buildah
    ];
  };
}
