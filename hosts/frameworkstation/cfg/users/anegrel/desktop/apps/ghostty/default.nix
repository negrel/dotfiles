{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [ my.ghostty-intel ];

      home.file.".config/ghostty/config".source = ./config/config;

      gen-theme.templates."ghostty" = {
        text = builtins.readFile ./templates/theme;
        destination = ".config/ghostty/themes/theme";
      };

      dot-profile.scripts."00-ghostty".text = ''
        export TERMINAL="ghostty"
      '';
    };
}
