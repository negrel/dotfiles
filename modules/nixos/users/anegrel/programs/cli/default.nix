{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cli-utils

    nix-index
    poppler_utils # PDF CLI
    unrar
    zip
    unzip
    usbutils # lsusb, etc
  ];

}
