{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      cli-utils.lsjson

      fzf
    ];

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

    zshrc.scripts = {
      "00-oh-my-zsh".text = ''
        ZSH_THEME="pmcgee"
        plugins=(git colored-man-pages)
      '';

      "fzf".text = ''
        plugins+="fzf"
        export FZF_DEFAULT_OPTS="--layout reverse"
      '';

      "aliases".text = ''
        alias df="df -h"
        alias free="free -h"
        alias cat="$(command -v bat || command -v cat || echo /bin/cat)"
        alias ls="$(command -v lsd || command -v ls || echo /bin/ls)"
        alias l="ls"
        alias la="l -a"
        alias ll="l -l"
        alias lla="la -l"
        alias du="du -sh"
        alias rm="rm -i"
        alias fd="fd -I"
        alias ip="ip -c"
        alias x="exit"
        alias :q="exit"
        alias :q!="exit"
        alias :qa="exit"
        alias :q!="exit"
        alias c="clear"

        # Process handling
        alias psg="ps aux | grep"
        alias ka9="killall -9"
        alias k9="kill -9"
      '';

      "functions".text = ''
        rwhich() {
          readlink -f $(which $@)
        }
      '';

      "autocompletion".text = ''
        autoload -U +X bashcompinit && bashcompinit
      '';
    };
  };
}
