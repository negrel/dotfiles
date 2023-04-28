{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      evolution
      protonmail-bridge
    ];

    dot-profile.scripts."99-protonmail-bridge".text = ''
      ${pkgs.protonmail-bridge}/bin/bridge -n & 2>/dev/null
    '';
  };
}
