{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tig
    neovim
  ];
}
