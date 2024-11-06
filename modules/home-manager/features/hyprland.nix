{
pkgs,
config,
lib,
...
}: {

  programs.rofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];

    settings = {
      exec-once = 
        [ 
          "mpd $XDG_CONFIG_HOME/mpd/mpd.conf"
                    #"hyprpaper "
          "$HOME/.local/bin/xdph_reset"
          "dunst -conf $XDG_CONFIG_HOME/bspwm/dunstrc"
          "/usr/lib/polkit-kde-authentication-agent-1"
          "$XDG_CONFIG_HOME/eww/launch "
          "nm-applet"
        ];
      monitor = ",preferred,0x0,1";
      "$terminal" = "alacritty";
      "$fileManager" = "lf";
      "$menu" = "rofi -show run";
      "$mod" = "SUPER";

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 0;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "master";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        #new_is_master = true
        new_on_top = true;
        new_status = "master";
      };

      gestures ={
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false;
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0;
        vrr = 1;
      };

      bind = 
        [
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, Q, killactive,"
          "$mod, G, togglefloating,"
          "$mod, S, togglesplit, # dwindle"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, layoutmsg, cycleprev"
          "$mod, J, layoutmsg, cyclenext "
          "$mod, TAB, layoutmsg, swapwithmaster "
          "$mod, RETURN, exec, $terminal"
          "$mod, SPACE, exec, $menu"
          "$mod, BACKSPACE, exec, sysact"
          "$mod, B, exec, ydotool type $(cat ~/.local/share/bookmarks/bookmarks | /usr/local/bin/dmenu-wl -i -l 50 | cut -d' ' -f1)"
          "$mod SHIFT, B, exec, makebookmark"
          "$mod SHIFT, L, exec, wayland-lock"
          "$mod, W, exec, firefox"
          "$mod, A, exec, pwvucontrol"
          "$mod, P, exec, passmenu"
          "$mod, T, exec, tempodmenu"
          "$mod, M, exec, ncmpcpp"
          "$mod, F, exec, alacritty -e newsboat"
          "$mod, C, exec, alacritty -e khal interactive"
          "$mod, M, exec, alacritty -e ncmpcpp"
          "$mod, E, exec, alacritty -e neomutt"
          "$mod, F9, exec, dmenumount"
          "$mod, F10, exec, dmenuumount"
          "$mod, F11, exec, dmenunerdfont"
          "$mod, F6, exec, calendarinfo"
          "$mod, F5, exec, info-notify"
        ]
        ++ (
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
            9)
        );

      bindm = 
        [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

      bindl = 
        [
          ", switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, auto\""
          ", switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
        ];
    };
  };
}
