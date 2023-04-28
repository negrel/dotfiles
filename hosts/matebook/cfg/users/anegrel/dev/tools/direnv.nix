{ ... }:

{
  home-manager.users.anegrel = { ... }: {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    zshrc.scripts."direnv".text = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
