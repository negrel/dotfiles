{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "sharecv";
  runtimeInputs = with pkgs; [
    bash
    localtunnel
    curl
    dufs
  ];
  text = builtins.readFile ./bin/sharecv;
}
