{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      go
    ];

    zshrc.scripts."00-go".text = ''
      export GOPATH="$HOME/.go"
      export PATH="$PATH:$GOPATH/bin"
    '';
  };
}
