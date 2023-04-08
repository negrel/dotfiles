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
    ./vscode
  ];

  home.packages = with pkgs; [
    lld
  ];
}
