{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "askai";
  runtimeInputs = with pkgs; [ bash ollama ];
  text = ''
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
  '';
}

