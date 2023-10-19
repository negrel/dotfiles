{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # LSP that mason fails to install.
      rnix-lsp
      sumneko-lua-language-server

      # terminal image viewer for telescope preview
      catimg
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    home.file.".config/nvim/".source = ./config;
    zshrc.scripts."00-nvim".text = ''
      export EDITOR=nvim
      if [ -n "$NVIM" ]; then
        export EDITOR=nano

        nvim() {
          ${pkgs.neovim}/bin/nvim --server $NVIM --remote-tab "$(realpath "$1")"
        }
      fi

      alias vi=nvim
      alias vim=vi
    '';
  };
}
