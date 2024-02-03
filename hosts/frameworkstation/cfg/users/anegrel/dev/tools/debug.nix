{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      lld
      tokio-console
      gdb
      gf
    ];
  };
}

