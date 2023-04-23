{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # under pkgs/
    cli-utils.lsjson

    # maintained by NixOS
    aichat
    jq
    unzip
    exa
    ripgrep
    fd
    bat
    gnumake
    htop
    ncdu
    neofetch
    nix-index
    poppler_utils # PDF CLI
    unrar
    zip
    unzip
    usbutils # lsusb, etc
    lsof
  ];
}
