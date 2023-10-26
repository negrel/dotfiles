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
      syntaxHighlighting.enable = true;
      initExtraBeforeCompInit = "source ~/.config/zsh/rc";
      initExtra = ''
        # Remove oh-my-zsh alias
        unalias gcd
      '';
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

        # cd like function using fzf
        fcd() {
          dir="$(find \
            -L ''${1:-"."} -mindepth 1 \
            \( -path '*/\.*' -o -fstype sysfs -o -fstype devs -o -fstype devtmpfs -o -fstype proc \) \
            -prune -o -type d -print \
            | fzf +m)"
          cd "$dir"
        }
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
        alias :qa!="exit"
        alias c="clear"
        alias ssh="TERM=xterm-256color ssh"
        alias cdtmp="cd $(mktemp -d)"

        # Process handling
        alias psg="ps aux | grep"
        alias ka9="killall -9"
        alias k9="kill -9"
      '';

      "functions".text = ''
        rwhich() {
          readlink -f $(which $@)
        }

        gcd() {
          local git_repo_root="$PWD"

          while [ ! -d "$git_repo_root/.git" ]; do
            git_repo_root="$(dirname "$git_repo_root")"
            if [ "$git_repo_root" = "/" ]; then return 1; fi
          done

          cd "$git_repo_root/$@"
        }
      '';

      "autocompletion".text = ''
        autoload -U +X bashcompinit && bashcompinit
      '';
    };
  };
}
