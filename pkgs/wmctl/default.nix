{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "wmctl";
  runtimeInputs = with pkgs; [ bash coreutils hyprland ];
  text = builtins.readFile ./bin/wmctl;
}

