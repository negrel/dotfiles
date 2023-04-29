{ pkgs, lib, ... }:
{
  users.users.anegrel = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "wireshark" ];
    hashedPassword = lib.my.readSecret "anegrel.hashedPassword";
  };
  programs.zsh.enable = true;

  home-manager.users.anegrel = { ... }@inputs:
    {
      # home-manager modules
      # imports recursively file under modules/home-manager while
      # inheriting pkgs and lib
      imports = builtins.map (el: (import el (lib.recursiveUpdate { inherit pkgs lib; } inputs)))
        (lib.my.buildImportListFrom ../../../../../modules/home-manager);

      gen-theme.enable = true;

      dot-profile.enable = true;
      dot-profile.scripts.".config/profile.d/00-local-bin".text = ''
        export PATH="$PATH:$HOME/.local/bin"
      '';

      home.stateVersion = "22.11";
    };
}
