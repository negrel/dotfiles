{ pkgs, ... }:

{
  dot-profile = pkgs.writeShellApplication {
    name = "dot-profile";
    runtimeInputs = with pkgs; [ bash coreutils ];
    text = builtins.readFile ./bin/dot-profile;
  };
}
