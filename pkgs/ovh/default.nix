{ pkgs, lib, ... }:

pkgs.writeShellApplication {
  name = "ovh";
  runtimeInputs = with pkgs; [ bash ];
  text = lib.my.readSecretFile "ovh" + builtins.readFile ./bin/ovh;
}
