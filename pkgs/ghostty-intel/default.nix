{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "ghostty";
  runtimeInputs = with pkgs; [
    ghostty
    nixGLIntel
  ];
  text = ''
    exec nixGLIntel ghostty "$@"
  '';
}
