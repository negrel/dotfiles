{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "wmctl";
  runtimeInputs = with pkgs; [ bash coreutils sway jq ];
  text = builtins.readFile ./bin/wmctl;
}

