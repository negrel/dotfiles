{ pkgs, ... }:

{
  home.packages = with pkgs; [
    evolution
    protonmail-bridge
  ];

  home.file.".config/profile.d/99-protonmail-bridge".text = ''
    ${pkgs.protonmail-bridge}/bin/bridge -n & 2>/dev/null
  '';
}
