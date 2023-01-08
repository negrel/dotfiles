{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
  ];

  home.file.".config/profile.d/00-go".text = ''
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$GOPATH/bin"
  '';
}
