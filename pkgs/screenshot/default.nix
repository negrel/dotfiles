{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "screenshot";
  runtimeInputs = with pkgs; [ bash coreutils wmctl grim slurp ];
  text = builtins.readFile ./bin/screenshot;
}

