{
config,
...
}: {
  programs.rofi = {
    enable = true;
    cycle = true;

    font = "JetBrains Mono Nerd Font 16";
    extraConfig = {
      modi = "run,filebrowser,window";
      case-sensitive = false;
      scroll-method = 0;
      normalize-match = true;
      icon-theme = "Papirus";
      steal-focus = false;

      matching = "normal";
      tokenize = true;

      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      run-command = "{cmd}";
      run-shell-command = "{terminal} -e {cmd}";

      run-fallback-icon = "application-x-addon";
      drun-fallback-icon = "application-x-addon";

      window-match-fields = "title,class,role,name,desktop";
      window-command = "wmctrl -i -R {window}";
      window-thumbnail = false;

      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;

      show-icons = false;
      display-drun = "";
      display-run = "";
      display-filebrowser = "";
      display-window = "";
      display-windowcd = "Window CD";
      display-ssh = "SSH";
      display-combi = "Combi";
      display-keys = "Keys";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      window-format = "{w} · {c} · {t}";

      terminal = "rofi-sensible-terminal";
      sort = false;
      threads = 0;
      click-to-exit = true;

      filebrowser-directories-first = true;
      filebrowser-sorting-method = "name";

      timeout-action = "kb-cancel";
      timeout-delay = " 0";
    };

  };
}
