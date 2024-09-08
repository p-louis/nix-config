{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myHomeManager;

  pimg = pkgs.writeShellScriptBin "pimg" ''
    output="out.png"
    [ ! -z "$1" ] && output="$1.png"
    # xclip -se c -t image/png -o > "$output"
    ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
  '';

in {
  home.file = {
    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    ".local/share/zsh/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -a --group-directories-first";
      tree = "${pkgs.eza}/bin/eza --color=auto --tree";
      cal = "cal -m";
      grep = "grep --color=auto";
      q = "exit";
      ":q" = "exit";
    };
  };

  programs.zsh.initExtra = ''
    # Enable colors and change prompt:
    autoload -U colors && colors	# Load colors
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
    setopt autocd		# Automatically cd into typed directory.
    stty stop undef		# Disable ctrl-s to freeze terminal.
    setopt interactive_comments

    # History in cache directory:
    HISTSIZE=10000000
    SAVEHIST=10000000
    export HISTFILE=$HOME/.cache/zsh/history



    # Load aliases and shortcuts if existent.
    [ -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && source "$XDG_CONFIG_HOME/shell/shortcutrc"
    [ -f "$XDG_CONFIG_HOME/shell/aliasrc" ] && source "$XDG_CONFIG_HOME/shell/aliasrc"
    [ -f "$XDG_CONFIG_HOME/shell/zshnameddirrc" ] && source "$XDG_CONFIG_HOME/shell/zshnameddirrc"

    # Basic auto/tab complete:
    autoload -U compinit
    zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache
    zmodload zsh/complist
    compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
    _comp_options+=(globdots)		# Include hidden files.

    # vi mode
    bindkey -v
    bindkey '^X^X' edit-command-line
    export KEYTIMEOUT=1

    # Use vim keys in tab complete menu:
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    bindkey -v '^?' backward-delete-char

    # Change cursor shape for different vi modes.
    function zle-keymap-select () {
        case $KEYMAP in
            vicmd) echo -ne '\e[1 q';;      # block
            viins|main) echo -ne '\e[5 q';; # beam
        esac
    }
    zle -N zle-keymap-select
    zle-line-init() {
        zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

    # Use lf to switch directories and bind it to ctrl-o
    lfcd () {
        tmp="$(mktemp)"
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp" >/dev/null
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    }
    bindkey -s '^o' 'ranger\n'

    bindkey -s '^a' 'bc -lq\n'

    bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

    bindkey '^[[P' delete-char

    # Edit line in vim with ctrl-e:
    autoload edit-command-line; zle -N edit-command-line
    bindkey '^e' edit-command-line

    # Load syntax highlighting; should be last.
    source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
    [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

    # Added by serverless binary installer
    export PATH="$HOME/.serverless/bin:$PATH"

    # powerline-daemon -q
    # . /usr/share/powerline/bindings/zsh/powerline.zsh
    #
    source "$HOME/.config/shell/profile"

    eval "$(zoxide init zsh)"
    eval "$(starship init zsh)"
    source <(fzf --zsh)

    export TERM="xterm-256color"

    fastfetch
  '';

  programs.zsh.envExtra = ''
    . "$HOME/.local/share/cargo/env"       
    export EDITOR="nvim"
    export TERMINAL="alacritty"
    export TERM="alacritty"
    export BROWSER="firefox"
    export VIDEO="mpv"
    export IMAGE="imv"
    export OPENER="xdg-open"
    export SCRIPTS="$HOME/scripts"
    export LAUNCHER="rofi -dmenu"
    export FZF_DEFAULT_OPTS="--color=16"

    # Less colors
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
    export vimcolorscheme="gruvbox"

    # direnv
    export DIRENV_LOG_FORMAT=""
  '';

  home.packages = [
    pimg

    (pkgs.writeShellScriptBin "mk" ''
      mkdir -p $( dirname "$1") && touch "$1"
    '')
  ];
}
