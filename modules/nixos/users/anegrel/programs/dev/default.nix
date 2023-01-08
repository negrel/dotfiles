{ pkgs, ... }:
{
  imports = [
    ./c
    ./git
    ./go
    ./neovim
    ./nodejs
    ./rust
    ./flutter
    ./docker
  ];

  home.packages = with pkgs; [
    lld
  ];
}
