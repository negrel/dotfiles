{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "askai";
  runtimeInputs = with pkgs; [ bash ollama ];
  text = builtins.readFile ./bin/askai.sh;
}

