{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lld
  ];
}
