{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      go
      # Required by pprof
      graphviz
    ];

    zshrc.scripts."00-go".text = ''
      export GOPATH="$HOME/.go"
      export PATH="$PATH:$GOPATH/bin"
    '';
  };
}
