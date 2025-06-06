# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  nixos-hardware,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  # Use latest zen kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a9965b88-3d59-4a6a-9cd9-ca0f974c843a";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=root"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/a9965b88-3d59-4a6a-9cd9-ca0f974c843a";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=nix"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/a9965b88-3d59-4a6a-9cd9-ca0f974c843a";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=home"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/28F5-1F06";
    fsType = "vfat";
  };

  fileSystems."/snapshots" = {
    device = "/dev/disk/by-uuid/a9965b88-3d59-4a6a-9cd9-ca0f974c843a";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=snapshots"
      "noatime"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Disable pulseaudio so there is no conflict with pipewire
  services.pulseaudio.enable = false;

  # Enable fstrimming
  services.fstrim.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  # AMD (https://wiki.nixos.org/wiki/AMD_GPU)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
