{ pkgs, lib, ... }:

{
  imports = lib.my.buildImportListFrom ../../../../../../modules/home-manager ++
    lib.my.buildImportListFrom ./programs;

  programs.gen-theme.enable = true;

  home.file.".config/profile.d/00-local-bin".text = ''
    export PATH="$PATH:$HOME/.local/bin"
  '';

  home.stateVersion = "22.11";
}
