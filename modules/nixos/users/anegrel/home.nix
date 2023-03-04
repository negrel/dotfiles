{ pkgs, ... }:

{
  imports = [
    ./programs/zsh
    ./programs/cli

    # Dev
    ./programs/dev
    ./programs/direnv

    # GUI
    ../../../home-manager/gen-theme.nix
    ./programs/hyprland
    ./programs/alacritty
    ./programs/firefox
    ./programs/settings
  ];
  programs.gen-theme.enable = true;

  home.file.".config/profile.d/00-local-bin".text = ''
    export PATH="$PATH:$HOME/.local/bin"
  '';

  home.stateVersion = "22.11";
}
