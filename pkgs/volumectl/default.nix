{ pkgs, lib, ... }:

pkgs.writeShellApplication {
  name = "volumectl";
  runtimeInputs = with pkgs; [ bash coreutils alsa-utils ];
  text = builtins.readFile ./bin/volumectl;
}
