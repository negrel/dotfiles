{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      vista-fonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [
          "FontAwesome"
          "Material Design Icons"
          "Noto Color Emoji"
        ];
      };
    };
  };
}
