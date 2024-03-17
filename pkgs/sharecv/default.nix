{ pkgs, lib, ... }:

pkgs.writeShellApplication {
  name = "sharecv";
  runtimeInputs = with pkgs; [ bash nodePackages.localtunnel curl dufs ];
  text = builtins.readFile ./bin/sharecv;
}
