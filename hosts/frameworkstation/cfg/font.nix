{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
      corefonts
      vistafonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "FontAwesome" "Material Design Icons" "Noto Color Emoji" ];
      };
    };
  };
}
