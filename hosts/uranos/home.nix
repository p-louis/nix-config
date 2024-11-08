{ 
pkgs, 
myConfig,
... 
}:
{
  imports = 
    [
      ../../modules/home-manager/default.nix
    ];
  myHomeManager = {
    bundles.general.enable = true;
    bundles.work.enable = true;

    zsh.enable = true;
    git.enable = true;
    hyprland.enable = true;
    rofi.enable = true;
    newsboat.enable = true;
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fuzzel";
  home.homeDirectory = "/home/fuzzel";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.lieer.enable = true;
  #programs.vdirsyncer.enable = true;
  services.lieer.enable = true;

  accounts.email.accounts.work = {
    primary = true;
    address = myConfig.workEmail;
    realName = myConfig.realName;
    gpg = {
      key = "293E5DCA20BDB8526F3C2652F74F4CD5EDDDFBAB";
      signByDefault = true;
    };
    flavor = "gmail.com";
    lieer = {
      enable = true;
      settings = {
        local_trash_tag = "deleted";
      };
      sync.enable = true;
      sync.frequency = "2m";
    };

    notmuch = {
      enable = true;
      neomutt = {
        enable = true;
        virtualMailboxes = 
          [
            {
              name = "INBOX";
              query = "notmuch://?query=(tag:inbox OR tag:sent) AND NOT tag:deleted AND NOT tag:junk AND NOT tag:killed AND NOT tag:archive";
            }
            {
              name = "Unread";
              query = "notmuch://?query=tag:unread";
            }
            {
              name = "Archive";
              query = "notmuch://?query=tag:archive";
            }
            {
              name = "Starred";
              query = "notmuch://?query=tag:*";
            }
            {
              name = "Sent";
              query = "notmuch://?query=tag:sent";
            }
          ];
      };
    };
    neomutt = {
      enable = false;
      sendMailCommand = "gmi send -t -C /home/fuzzel/.local/share/mail/";
      mailboxType = "maildir";
      mailboxName = "INBOX";
    };

    aliases = 
      [
        "patrick.louis@partner.ionity.eu"
      ];
    signature.text = ''
            Patrick Louis

            +49 170 6137 553
            patrick.louis@linked-planet.com

            linked-planet GmbH
            Hopfenstraße 6
            80335 München

            www.linked-planet.com

            Geschäftsführer: Dr. Georg Schwarz, Alexander
            Weickmann, Manuel Miller
            Registergericht: Amtsgericht München
            Registernummer: HRB 246118
            Umsatzsteuer-Identifikationsnummer: DE322411089
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL="alacritty";
    TERM="alacritty";
    BROWSER="firefox";
    VIDEO="mpv";
    IMAGE="imv";
    OPENER="xdg-open";
    SCRIPTS="$HOME/scripts";
    LAUNCHER="rofi -dmenu";
    FZF_DEFAULT_OPTS="--color=16";
    DIRENV_LOG_FORMAT="";

    XDG_CONFIG_HOME="$HOME/.config";
    XDG_DATA_HOME="$HOME/.local/share";
    XDG_CACHE_HOME="$HOME/.cache";
    XDG_STATE_HOME="$HOME/.local/state";
    XDG_RUNTIME_DIR="/run/user/$(id -u)";
    PROJECT_HOME="$HOME/documents/projects";
    XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority";
    LESSHISTFILE="-";
    WGETRC="$HOME/.config/wget/wgetrc";
    INPUTRC="$HOME/.config/shell/inputrc";
    ZDOTDIR="$HOME/.config/zsh";
    GNUPGHOME="$HOME/.local/share/gnupg";
    PASSWORD_STORE_DIR="$HOME/.local/share/password-store";
    TMUX_TMPDIR="$XDG_RUNTIME_DIR";
    ANDROID_SDK_HOME="$HOME/.config/android";
    CARGO_HOME="$HOME/.local/share/cargo";
    GOPATH="$HOME/.local/share/go";
    ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg";
    UNISON="$HOME/.local/share/unison";
    HISTFILE="$HOME/.local/share/history";
    AWS_CONFIG_FILE="$HOME/.config/aws/config";
    AWS_SHARED_CREDENTIALS_FILE="$HOME/.local/share/aws/credentials";
    _JAVA_OPTIONS="-Djava.util.prefs.userRoot=\"$XDG_CONFIG_HOME\"/java";
    DOCKER_CONFIG="$XDG_CONFIG_HOME/docker";
    GRADLE_USER_HOME="$XDG_DATA_HOME/gradle";
    RANDFILE="$XDG_DATA_HOME/openssl/rnd";
    ELM_HOME="$XDG_CONFIG_HOME/elm";
    REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history";
    REDISCLI_RCFILE="$XDG_CONFIG_HOME/redis/redisclirc";
    XINITRC="$XDG_CONFIG_HOME/x11/xinitrc";
    XSERVERRC="$XDG_CONFIG_HOME/x11/xserverrc";
    TEXMFHOME="$XDG_DATA_HOME/texmf";
    TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var";
    TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config";
    PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc";
    PSQL_HISTORY="$XDG_STATE_HOME/psql_history";
    PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass";
    PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf";
    RUSTUP_HOME="$XDG_CONFIG_HOME/rustup/config";

    FLAKE="$HOME/documents/nix-config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
