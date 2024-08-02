{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # under pkgs/
      cli-utils.lsjson
      cli-utils.uuid
      run-with-quotas
      ovh

      # nixpkgs
      jq
      unzip
      eza
      ripgrep
      fd
      bat
      gnumake
      htop
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
      clinfo
      moreutils
      # AMD
      amdgpu_top
      # Kernel specific
      linuxKernel.packages.linux_zen.cpupower
      # TUI file manager
      fff
    ];
  };
}

