{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        rofi
      ];

      home.file.".config/rofi/config.rasi".source = ./config/config.rasi;
      gen-theme.templates."rofi" = {
        source = ./templates/rofi;
        destination = ".config/rofi/themes/theme.rasi";
      };
    };
}
