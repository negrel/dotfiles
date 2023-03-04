{ pkgs, ... }:

rec {
  wmctl = pkgs.writeShellApplication {
    name = "wmctl";
    runtimeInputs = with pkgs; [ bash coreutils ];
    text = builtins.readFile ./bin/wmctl;
  };
}

