{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # LSP that mason fails to install.
      rnix-lsp
      sumneko-lua-language-server
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    home.file.".config/nvim/".source = ./config;
    zshrc.scripts."00-nvim".text = ''
      export EDITOR=nvim
      if [ -n "$NVIM" ]; then
        nvim() {
          ${pkgs.neovim}/bin/nvim --server $NVIM --remote "$@"
        }
      fi

      alias vi=nvim
      alias vim=vi
    '';
  };
}
