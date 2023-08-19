{ pkgs, ... }:

{
  lsjson =
    pkgs.writeShellApplication
      {
        name = "lsjson";
        runtimeInputs = with pkgs; [ bash coreutils jq ];
        text = builtins.readFile ./bin/lsjson;
        checkPhase = "";
      };
  uuid =
    pkgs.writeShellApplication
      {
        name = "uuid";
        runtimeInputs = with pkgs; [ bash coreutils ];
        text = builtins.readFile ./bin/uuid;
        checkPhase = "";
      };
}

