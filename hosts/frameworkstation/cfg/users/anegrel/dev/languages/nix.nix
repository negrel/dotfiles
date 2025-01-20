{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [ nixd nixfmt-rfc-style ];
  };
}
