{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tig

    vim
    vscodium
  ];
}
