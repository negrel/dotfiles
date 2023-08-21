{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # evolution
      # protonmail-bridge
      # evolution-with-protonmail-bridge
    ];
  };
}
