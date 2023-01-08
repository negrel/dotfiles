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
  ];

  home.packages = with pkgs; [
    lld
  ];
}
