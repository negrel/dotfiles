{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixGLIntel
  ];
}
