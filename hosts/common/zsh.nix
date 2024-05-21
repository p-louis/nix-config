{ pkgs, ... }: {
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableAutosuggestions = true;
    history.size = 10000;
    history.share = true;
    history.path = "$HOME/.cache/zsh/history";

    plugins = [
    ];

    initExtraFirst = ''
    autoload -U colors && colors	# Load colors
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
    stty stop undef		# Disable ctrl-s to freeze terminal.
    '';

    initExtra = ''
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
    '';

    shellAliases = {
      # Overrides those provided by OMZ libs, plugins, and themes.
      # For a full list of active aliases, run `alias`.

      #-------------Bat related------------
      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";

      #------------Navigation------------
      doc = "cd $HOME/documents";
      scripts = "cd $HOME/scripts";
      ts = "cd $HOME/.talon/user/fidget";
      src = "cd $HOME/src";
      edu = "cd $HOME/src/edu";
      dfs = "cd $HOME/src/dotfiles";
      dfsw = "cd $HOME/src/dotfiles.wiki";
      nfs = "cd $HOME/nix-config";
      uc = "cd $HOME/src/unmovedcentre";
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
      lsa = "eza -lah";

      #-------------Neovim---------------
      e = "nvim";
      vi = "nvim";
      vim = "nvim";

      #-----------Nix related----------------
      ne = "nix-instantiate --eval";
      nb = "nix-build";
      ns = "nix-shell";

      #-----------Remotes----------------
      # cakes = "ssh -l freshcakes freshcakes.memeoid.cx";
      # gooey = "ssh -l pi 10.13.37.69";
      # gusto = "ssh -l ta 10.13.37.5";
      # grief = "ssh -l ta 10.13.37.7";

      #-------------Git Goodness-------------
      # just reference `$ alias` and use the defautls, they're good.
    };
  };
}
