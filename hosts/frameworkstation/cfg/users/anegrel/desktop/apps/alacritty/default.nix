{ pkgs, lib, ... }:

{
  home-manager.users.anegrel = { lib, ... }: with lib; {
    home.packages = with pkgs; [
      alacritty
    ];

    gen-theme.templates."alacritty.yml" = {
      text = builtins.readFile ./templates/config.yml;
      destination = ".config/alacritty/alacritty.yml";
    };

    dot-profile.scripts."00-alacritty".text = ''
      export TERMINAL="alacritty -e"
    '';
  };
}
