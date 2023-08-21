{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono" ];
        emoji = [ "FontAwesome" "Material Design Icons" "Noto Color Emoji" ];
      };
    };
  };
}
