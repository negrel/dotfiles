{ pkgs, ... }:

{
  home-manager.users.anegrel = { lib, ... }:
    with lib; {
      home.packages = with pkgs; [ alacritty ];

      gen-theme.templates."alacritty.toml" = {
        text = builtins.readFile ./templates/config.toml;
        destination = ".config/alacritty/alacritty.toml";
      };
    };
}
