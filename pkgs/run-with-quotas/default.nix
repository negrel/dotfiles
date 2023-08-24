{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "rwq";
  runtimeInputs = with pkgs; [ bash systemd ];
  text = builtins.readFile ./bin/rwq;
}
