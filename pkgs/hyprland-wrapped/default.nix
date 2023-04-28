{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "hyprland-wrapped";
  runtimeInputs = with pkgs; [
    bash
    hyprland
    dot-profile
  ];
  text = builtins.readFile ./bin/hyprland-wrapped;
}
