{ pkgs, ... }:

rec {
  lsjson = pkgs.writeShellApplication {
    name = "lsjson";
    runtimeInputs = with pkgs; [ bash coreutils jq ];
    text = builtins.readFile ./bin/lsjson;
    checkPhase = "";
  };
}

