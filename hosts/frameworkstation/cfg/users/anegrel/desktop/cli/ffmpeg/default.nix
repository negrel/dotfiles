{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      ffmpeg-full
    ];
  };
}
