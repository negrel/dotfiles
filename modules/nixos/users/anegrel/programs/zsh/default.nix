{ pkgs, ... }:

{
  home.packages = with pkgs; [ fzf ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtraBeforeCompInit = "source ~/.config/zsh/rc";
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
    };
  };

  home.file.".config/zsh/".source = ./config;
}
