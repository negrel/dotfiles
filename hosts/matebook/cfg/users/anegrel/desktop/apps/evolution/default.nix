{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      evolution
      protonmail-bridge
    ];

    dot-profile.scripts."protonmail-bridge".text = ''
      ${pkgs.protonmail-bridge}/bin/protonmail-bridge -n & 2>/dev/null
    '';
  };
}
