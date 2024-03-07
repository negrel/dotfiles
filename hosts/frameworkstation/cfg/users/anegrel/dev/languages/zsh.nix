{ nix-index-database, pkgs, ... }:

{

  home-manager.users.anegrel = { ... }: {
    # Import nix-index-database module for command not found handler.
    imports = [
      nix-index-database.hmModules.nix-index
    ];
    # Enable nixpkgs index.
    programs.nix-index.enable = true;
    # Comma allow running commands without installing them.
    programs.nix-index-database.comma.enable = true;

    home.packages = with pkgs; [
      cli-utils.lsjson

      fzf
    ];

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initExtraBeforeCompInit = ''
        ZSH_THEME="pmcgee"
        plugins=(git colored-man-pages fzf)

        export FZF_DEFAULT_OPTS="--layout reverse"
      '';
      initExtra = "source ~/.config/zsh/rc";
      history.size = 10000;

      oh-my-zsh = {
        enable = true;
      };
    };

    zshrc.scripts = {
      "fzf".text = ''
        # cd like function using fzf
        fcd() {
          local dir="$(find \
            -L ''${1:-"."} -mindepth 1 \
            \( -path '*/\.*' -o -fstype sysfs -o -fstype devs -o -fstype devtmpfs -o -fstype proc \) \
            -prune -o -type d -print \
            | fzf +m)"
          cd "$dir"
        }

        fcmd() {
          local cmd="$(tr ':' '\n' <<< "$PATH" \
            | xargs -P $(nproc) -I{} find -L "{}" -type f -executable 2> /dev/null \
            | xargs -P $(nproc) -I{} basename "{}" \
            | fzf)"
          print -z "$cmd"
        }
      '';

      "aliases".text = ''
        alias df="df -h"
        alias free="free -h"
        alias cat="$(command -v cat || echo /bin/cat)"
        unalias ls # oh-my-zsh
        alias ls="$(command -v lsd || command -v ls || echo /bin/ls) --color=tty"
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
        alias cdtmp="cd $(mktemp -d)"

        # Process handling
        alias psg="ps aux | grep"
        alias ka9="killall -9"
        alias k9="kill -9"
      '';

      "functions".text = ''
        rwhich() {
          readlink -f "$(which $@)"
        }

        unalias gcd # alias from oh-my-zsh git plugins
        gcd() {
          local git_repo_root="$PWD"

          while [ ! -d "$git_repo_root/.git" ]; do
            git_repo_root="$(dirname "$git_repo_root")"
            if [ "$git_repo_root" = "/" ]; then return 1; fi
          done

          cd "$git_repo_root/$@"
        }

        cpr() {
          rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
        }
      '';

      "autocompletion".text = ''
        autoload -U +X bashcompinit && bashcompinit
      '';

      "command_not_found_handler".text = ''
        command_not_found_handler() {
          printf "%s is not installed, calling comma..." "$1"
          # Just forward to comma.
          , $@
        }
      '';
    };
  };
}
