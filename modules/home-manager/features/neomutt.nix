{
pkgs,
...
}: {
  programs.neomutt = {
    enable = true;

    editor = "nvim +'set spell spelllang=en_us,de_de' +/^$/";

    unmailboxes = true;
    sourcePrimaryAccount = false;

    sidebar = {
      enable = true;
      width = 20;
    };

    sort = "threads";

    macros = 
      [
        {
          map = [
            "index"
          ];
          key = ",@)";
          action = "<enter-command set sidebar_visible=no; macro index ~ ,@( 'Toggle sidebar'<Enter>";
        }
        {
          map = [
            "index"
          ];
          key = ",@(";
          action = "<enter-command set sidebar_visible=yes; macro index ~ ,@) 'Toggle sidebar'<Enter>";
        }
        {
          map = [
            "index"
          ];
          key = "~";
          action = ",@)";
        }
        {
          map = [
            "index"
          ];
          key = "I";
          action = "<modify-labels>-inbox -unread<enter>";
        }
        {
          map = [
            "index"
          ];
          key = "A";
          action = "<modify-labels-then-hide>-inbox -unread +archive<enter>";
        }
        {
          map = [
            "index"
          ];
          key = "S";
          action = "<modify-labels-then-hide>-inbox -unread +junk<enter>";
        }
        {
          map = [
            "index"
          ];
          key = "+";
          action = "<modify-labels-then-hide>+*<enter>";
        }
        {
          map = [
            "index"
          ];
          key = "-";
          action = "<modify-labels-then-hide>-*<enter>";
        }
        {
          map = [
            "index"
          ];
          key = "D";
          action = "<modify-labels-then-hide>-unread -inbox +deleted<enter>";
        }

        {
          map = [
            "index"
          ];
          key = "\\\\";
          action = "<vfolder-from-query>";
        }
        {
          map = [
            "index"
          ];
          key = "//";
          action = "<vfolder-from-query>";
        }

        {
          map = [
            "browser"
          ];
          key = "h";
          action = "<change-dir><kill-line>..<enter>";
        }

        {
          map = [
            "pager"
          ];
          key = "\Cb";
          action = "<pipe-entry>'urlview'<enter>";
        }
        {
          map = [
            "index"
            "pager"
          ];
          key = "E";
          action = "<pipe-message>khard add-email<return>";
        }
      ];

    binds = 
      [
        {
          map = [
            "index"
          ];
          key = "<left>";
          action = "sidebar-prev";
        }
        {
          map = [
            "index"
          ];
          key = "<right>";
          action = "sidebar-next";
        }
        {
          map = [
            "index"
          ];
          key = "<space>";
          action = "sidebar-open";
        }

        {
          map = [
            "index"
            "pager"
          ];
          key = "i";
          action = "noop";
        }
        {
          map = [
            "index"
            "pager"
          ];
          key = "h";
          action = "noop";
        }
        {
          map = [
            "index"
            "pager"
          ];
          key = "g";
          action = "noop";
        }
        {
          map = [
            "index"
            "pager"
          ];
          key = "M";
          action = "noop";
        }
        {
          map = [
            "index"
            "pager"
          ];
          key = "C";
          action = "noop";
        }
        {
          map = [
            "index"
          ];
          key = "\Cf";
          action = "noop";
        }

        {
          map = [
            "index"
            "pager"
          ];
          key = "\\\`";
          action = "modify-labels";
        }

        {
          map = [
            "index"
          ];
          key = "gg";
          action = "first-entry";
        }
        {
          map = [
            "index"
          ];
          key = "G";
          action = "last-entry";
        }
        {
          map = [
            "index"
          ];
          key = "j";
          action = "next-entry";
        }
        {
          map = [
            "index"
          ];
          key = "k";
          action = "previous-entry";
        }
        {
          map = [
            "index"
          ];
          key = "L";
          action = "limit";
        }
        {
          map = [
            "index"
          ];
          key = "@";
          action = "sync-mailbox";
        }
        {
          map = [
            "index"
          ];
          key = "\031";
          action = "previous-undeleted";
        }
        {
          map = [
            "index"
          ];
          key = "\005";
          action = "next-undeleted";
        }
        {
          map = [
            "index"
          ];
          key = "U";
          action = "undelete-message";
        }

        {
          map = [
            "index"
            "pager"
          ];
          key = "H";
          action = "view-raw-message";
        }
        {
          map = [
            "index"
            "pager"
            "browser"
          ];
          key = "d";
          action = "half-down";
        }
        {
          map = [
            "index"
            "pager"
            "browser"
          ];
          key = "u";
          action = "half-up";
        }

        {
          map = [
            "pager"
          ];
          key = "l";
          action = "view-attachments";
        }
        {
          map = [
            "pager"
          ];
          key = "\031";
          action = "previous-line";
        }
        {
          map = [
            "pager"
          ];
          key = "\005";
          action = "next-line";
        }

        {
          map = [
            "attach"
          ];
          key = "<return>";
          action = "view-mailcap";
        }
        {
          map = [
            "attach"
          ];
          key = "l";
          action = "view-mailcap";
        }
        {
          map = [
            "pager"
            "attach"
          ];
          key = "h";
          action = "exit";
        }
      ];
    extraConfig = ''
            color sidebar_new yellow default
            set header_cache = $HOME/.local/share/mutt/cache/headers
            set message_cachedir = $HOME/.local/share/mutt/cache/bodies
            set certificate_file = $HOME/.local/share/mutt/certificates

            set move = no
            # set mbox_type=Maildir
            set folder = $HOME/.local/share/mail/
            set sendmail = "gmi send -t -C /home/fuzzel/.local/share/mail/"

            set mime_type_query_command = "file --mime-type -b %s"

            set sig_on_top = yes

            set spoolfile = ""

            set sort_aux = 'reverse-last-date-received'
            set sort = 'threads'
            set date_format="%y/%m/%d %I:%M%p"

            set mailcap_path = $HOME/.config/mutt/mailcap:/usr/local/share/mutt-wizard/mailcap:$mailcap_path

            tag-transforms "inbox" "" \
                           "unread"  "" \
                           "replied" "" \
                           "sent"    "" \
                           "signed"  "" \
                           "todo"    "" \
                           "deleted" "" \
                           "*"       "" \
                           "archive"  "󰀼" \
                           "invitation" "" \
                           "attachment" "" \
                           "lists/dev" "" \
                           "lists" "" \
                           "important" ""

            set index_format='%4C|%<[y?%<[m?%<[d?%[     %H:%M]&%[    %a %d]>&%[    %b %d]>&%[%d/%m/%Y]>| %5g | %-35.35F  %?GR?%GR&　? %?GA?%GA&　? %?GD?%GD&%GC?  %s'

            set sleep_time = 0    # Pause 0 seconds for informational messages
            set markers = no    # Disables the `+` displayed at line wraps
            set mark_old = no   # Unread mail stay unread until read
            set mime_forward = yes    # attachments are forwarded with mail
            set wait_key = no   # mutt won't ask "press key to continue"
            set fast_reply      # skip to compose when replying
            set fcc_attach      # save attachments with the body
            set forward_format = "Fwd: %s"  # format of subject when forwarding
            set forward_quote   # include message in forwards
            set reverse_name    # reply as whomever it was to
            set include     # include message in replies

            set editor="nvim +'set spell spelllang=en_us,de_de' +/^$/"
            set query_command= "khard email --parsable --search-in-source-files %s"

            auto_view text/html
            auto_view application/pgp-encrypted
            alternative_order text/plain text/enriched text/html

            # GPG
            set crypt_use_gpgme=yes
            set postpone_encrypt = yes
            set pgp_self_encrypt = yes
            set crypt_use_pka = no
            set crypt_autosign = yes
            set crypt_autoencrypt = yes
            set crypt_autopgp = yes 
            set crypt_protected_headers_write = yes
            set pgp_use_gpg_agent = yes
            set pgp_timeout       = 3600
            set pgp_autosign      = yes
            set pgp_sign_as       = "361908F97DD5E21D"
            set pgp_default_key   = "361908F97DD5E21D"
            unset smime_is_default


            # Colors
            color normal brightwhite black
            color hdrdefault cyan default
            color attachment yellow default

            color header blue black "From: "
            color header blue black "Subject: "
            color header blue black "Date: "
            color header green  black "^(from|subject):"
            color header blue  black "^(To|CC):"

            color quoted green default
            color quoted1 cyan default
            color quoted2 green default
            color quoted3 cyan default

            color error red default # error messages
            color message brightwhite default # message  informational messages
            color indicator black magenta # indicator for the "current message"
            color status black blue # status lines in the folder index sed for the mini-help line
            color tree  red default # the "tree" display of threads within the folder index
            color search white blue            # search matches found with search within the internal pager
            color markers red default         # The markers indicate a wrapped line hen showing messages with looong lines
            color hdrdefault blue white

            uncolor index *
            color index      white         default  ~Q # Beantwortete Nachrichten
            color index      brightred     default  ~F # Markierte Nachrichten
            color index      yellow        default  ~N # Neue Nachrichten
            color index      green         default  ~O # Ungelesene Nachrichten
            color index      magenta       default  ~T # Getaggte Nachrichten
            color index      black         default  ~D # Gelöschte Nachrichten
    '';
  };
}
