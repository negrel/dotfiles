{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # under pkgs/
      cli-utils.lsjson
      cli-utils.uuid
      run-with-quotas
      ovh

      # maintained by NixOS
      jq
      unzip
      eza
      ripgrep
      fd
      bat
      gnumake
      htop
      amdgpu_top
      ncdu
      neofetch
      poppler_utils # PDF CLI
      unrar
      zip
      unzip
      usbutils # lsusb, etc
      lsof
      pstree
      pciutils
      tree
      dig
      bind
      nmap
      file
      cachix
      sshfs

      # Kernel specific
      linuxKernel.packages.linux_zen.cpupower
    ];
  };
}

