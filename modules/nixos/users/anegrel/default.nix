{ pkgs, ... }:

{
  imports = [
    ../../wrapped-hyprland.nix
    ../../eww.nix
  ];

  users = {
    users.anegrel = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "wireshark" ];
      hashedPassword = "$y$j9T$bNHHS/SFtBYCeeLztoTRM.$gkWJMG.oE5je.dVneLDZBK5aASBOrHl3v2Q9tzY.2a5";
    };
  };

  programs.sway.enable = true;
  programs.wrapped-hyprland.enable = true;
  programs.eww.enable = true;

  # Import home manager config
  home-manager.users.anegrel = import ./home.nix;
}
