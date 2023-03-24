{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # under pkgs/
    lsjson
    aichat

    # maintained by NixOS
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
  ];
}
