{ pkgs, ... }:

rec {
  cli-utils = pkgs.symlinkJoin {
    name = "cli-utils";
    paths = with pkgs; [
      jq
      unzip
      exa
      ripgrep
      fd
      bat
      gnumake
      htop
      ncdu
      neofetch
    ] ++ [
      lsjson
    ];
  };

  lsjson = pkgs.writeShellApplication {
    name = "lsjson";
    runtimeInputs = with pkgs; [ bash coreutils jq ];
    text = builtins.readFile ./bin/lsjson;
    checkPhase = "";
  };
}

