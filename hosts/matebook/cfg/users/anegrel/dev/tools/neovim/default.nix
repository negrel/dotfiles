{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # Home manager install as neovim mason fail to install it
      rnix-lsp
      sumneko-lua-language-server
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    home.file.".config/nvim/".source = ./config;
    zshrc.scripts."00-nvim".text = ''
      if [ -n "$NVIM" ]; then
        export EDITOR=nano
      else
        export EDITOR=nvim
      fi
    '';
  };
}
