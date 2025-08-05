{ nix-index-database, ... }:

{

  home-manager.users.anegrel =
    { pkgs, ... }:
    {
      # Import nix-index-database module for command not found handler.
      imports = [ nix-index-database.homeModules.nix-index ];

      programs.nix-index.enableZshIntegration = false;
      programs.nix-index-database.comma.enable = true;

      home.packages = with pkgs; [
        my.cli-utils.lsjson
        fzf
      ];

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        initContent = ''
          export FZF_DEFAULT_OPTS="--layout reverse"

          source ~/.config/zsh/rc
        '';
        history = {
          size = 1000000000;
          append = true;
        };

        oh-my-zsh = {
          enable = true;
          theme = "pmcgee";
          extraConfig = ''
            plugins=(git colored-man-pages fzf)
          '';
        };
      };

      zshrc.scripts = {
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

          tldr() {
            for cmd in "$@"; do
              curl "https://cheat.sh/''${cmd}"
            done
          }
        '';

        "autocompletion".text = ''
          autoload -U +X bashcompinit && bashcompinit
        '';

        "command_not_found_handler".text = ''
          command_not_found_handler() {
            printf "%s is not installed, calling comma..." "$1"
            # Just forward to comma.
            comma $@
          }
        '';
      };
    };
}
