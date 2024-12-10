{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # LSP that mason fails to install.
      nil
      nixpkgs-fmt # Nix LSP and formatter
      sumneko-lua-language-server

      # terminal image viewer for telescope preview
      catimg

      # Required to build telescope-fzf extension.
      cmake
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
          ${pkgs.neovim}/bin/nvim --server $NVIM --remote-tab "$(realpath "''${1:-.}")"
        }
      else
        nvim() {
          local dir="$(realpath "''${1:-$PWD}")"
          title "nvim $(basename "$dir")"
          ${pkgs.neovim}/bin/nvim "$dir"
        }
      fi

      alias vi=nvim
      alias vim=vi
    '';
  };
}
