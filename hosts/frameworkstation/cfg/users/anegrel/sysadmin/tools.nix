{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        # under pkgs/
        my.cli-utils.lsjson
        my.cli-utils.uuid
        my.run-with-quotas
        my.ovh
        my.cp-rsync

        # nixpkgs
        jq
        # modern ls replacement
        eza
        # modern grep replacement
        ripgrep
        # modern find alternative
        fd
        # cat alternative with syntax highlighting
        bat
        # make
        gnumake
        # TUI process manager
        htop
        # ncurses du
        ncdu
        # system info fetcher
        neofetch
        # PDF CLI
        poppler_utils
        # Archive
        unrar
        zip
        unzip
        # lsusb
        usbutils
        # List files open by process
        lsof
        # Process tree.
        pstree
        # lspci
        pciutils
        # Print files as a tree.
        tree
        # DNS tools
        dig
        bind
        # Map network
        nmap
        # Determine file type.
        file
        # Nix Cachix
        cachix
        ## SSH fuse
        sshfs
        # OpenCL
        clinfo
        # Coreutils extensions
        moreutils
        # AMD
        amdgpu_top
        # Kernel specific
        linuxKernel.packages.linux_zen.cpupower
        # TUI file manager
        fff
        # Encrypted FUSE.
        gocryptfs
        # rsync for cloud storage.
        rclone
      ];
    };
}
