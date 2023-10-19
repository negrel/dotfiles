{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "wmctl";
  runtimeInputs = with pkgs; [ bash coreutils sway ];
  text = builtins.readFile ./bin/wmctl;
}

