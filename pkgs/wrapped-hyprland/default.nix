{ pkgs, ... }:

rec {
  wrapped-hyprland = pkgs.writeShellApplication {
    name = "wrapped-hyprland";
    runtimeInputs = with pkgs; [
      bash
      coreutils
      hyprland
      #dot-profile
    ];
    text = builtins.readFile ./bin/wrapped-hyprland;
  };
}
