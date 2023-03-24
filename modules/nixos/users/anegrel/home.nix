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
    ./programs/alacritty
    ./programs/firefox
  ];
  programs.gen-theme.enable = true;

  home.file.".config/profile.d/00-local-bin".text = ''
    export PATH="$PATH:$HOME/.local/bin"
  '';

  home.stateVersion = "22.11";
}
