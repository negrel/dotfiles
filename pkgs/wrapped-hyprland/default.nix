{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "wrapped-hyprland";
  runtimeInputs = with pkgs; [
    bash
    hyprland
    dot-profile
  ];
  text = builtins.readFile ./bin/wrapped-hyprland;
}
