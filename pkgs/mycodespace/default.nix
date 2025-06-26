{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "mycodespace";
  runtimeInputs = with pkgs; [
    bash
    ttyd
    openssh
    iproute2
  ];
  text = builtins.readFile ./bin/mycodespace;
}
