{ ... }: {
  imports = [
    ./bios.nix
    ./boot.nix
    ./desktop.nix
    ./devtools.nix
    ./hardware-configuration.nix
    ./layout.nix
    ./locale.nix
    ./network.nix
    ./sound.nix
    ./time.nix
    ./users/default.nix
  ];

  system.stateVersion = "26.05";
}
