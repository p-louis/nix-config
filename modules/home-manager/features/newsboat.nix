{
...
}: {
  programs.newsboat = {
    enable = true;
    autoReload = true;
    maxItems = 100;
    browser = "linkhandler";

    urls = 
      [
        {
          url = "https://rss.sueddeutsche.de/rss/Topthemen";
          title= "Sueddeutsche Zeitung";
          tags = [ "news" ];
        }
        {
          url = "https://www.tagsesschau.de/xml/rss2/";
          title= "tagsesschau.de";
          tags = [ "news" ];
        }
        {
          url = "https://distrowatch.com/news/dw.xml";
          title= "DistroWatch";
          tags = [ "newsfeed" ];
        }
        {
          url = "http://lxer.com/module/newswire/headlines.rss";
          title= "LXer";
          tags = [ "newsfeed" ];
        }
        {
          url = "https://itsfoss.com/feed/";
          title= "It's Foss";
          tags = [ "newsfeed" ];
        }
        {
          url = "https://www.gamingonlinux.com/article_rss.php";
          title= "Gaming On Linux";
          tags = [ "newsfeed" ];
        }
        {
          url = "https://www.reddit.com/r/linux.rss";
          title= "r/linux";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/commandline.rss";
          title= "r/commandline";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/linux4noobs.rss";
          title= "r/linux4noobs";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/linuxquestions.rss";
          title= "r/linuxquestions";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/linuxmasterrace.rss";
          title= "r/linuxmasterrace";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/linux_gaming.rss";
          title= "r/linux_gaming";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/linuxaudio.rss";
          title= "r/linuxaudio";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/archlinux.rss";
          title= "r/archlinux";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/vim.rss";
          title= "r/vim";
          tags = [ "reddit" ];
        }
        {
          url = "https://www.reddit.com/r/unixporn.rss";
          title= "r/unixporn";
          tags = [ "reddit" ];
        }
        {
          url = "https://github.com/p-louis/dotfiles/commits/master.atom";
          title= "dotfiles";
          tags = [ "git-repos" ];
        }
        {
          url = "https://github.com/p-louis/st/commits/master.atom";
          title= "st";
          tags = [ "git-repos" ];
        }
        {
          url = "https://github.com/p-louis/dwm/commits/master.atom";
          title= "dwm";
          tags = [ "git-repos" ];
        }
        {
          url = "https://github.com/p-louis/dwmblocks/commits/master.atom";
          title= "dwmblocks";
          tags = [ "git-repos" ];
        }
        {
          url = "https://github.com/p-louis/dmenu/commits/master.atom";
          title= "dmenu";
          tags = [ "git-repos" ];
        }
        {
          url = "https://www.archlinux.org/feeds/packages/added/";
          title= "Packages Added";
          tags = [ "archlinux" ];
        }
        {
          url = "https://www.archlinux.org/feeds/packages/removed/";
          title= "Packages Removed";
          tags = [ "archlinux" ];
        }
        {
          url = "https://aur.archlinux.org/rss/";
          title= "Packages Added (AUR)";
          tags = [ "archlinux" ];
        }
        {
          url = "https://wiki.archlinux.org/api.php?hidebots=1&urlversion=1&days=7&limit=50&action=feedrecentchanges&feedformat=rss";
          title= "Arch Wiki";
          tags = [ "archlinux" ];
        }
        {
          url = "https://www.deutschlandfunk.de/podcast-104.xml";
          title= "Der tags";
          tags = [ "podcasts" ];
        }
        {
          url = "https://www.deutschlandfunk.de/podcast-deep-science-100.xml";
          title= "Deep Science";
          tags = [ "podcasts" ];
        }
        {
          url = "https://www.deutschlandfunk.de/nachrichten-108.xml";
          title= "Nachrichten";
          tags = [ "podcasts" ];
        }
        {
          url = "https://www.deutschlandfunk.de/essay-und-diskurs-102.xml";
          title= "Essay und Diskurs";
          tags = [ "podcasts" ];
        }
      ];
    extraConfig = ''
            external-url-viewer "urlscan -dc -r 'linkhandler {}'"

            bind-key j down
            bind-key k up
            bind-key j next articlelist
            bind-key k prev articlelist
            bind-key J next-feed articlelist
            bind-key K prev-feed articlelist
            bind-key G end
            bind-key g home
            bind-key d pagedown
            bind-key u pageup
            bind-key l open
            bind-key h quit
            bind-key a toggle-article-read
            bind-key n next-unread
            bind-key N prev-unread
            bind-key D pb-download
            bind-key U show-urls
            bind-key x pb-delete

            color listnormal cyan default
            color listfocus black yellow standout bold
            color listnormal_unread blue default
            color listfocus_unread yellow default bold
            color info red black bold
            color article white default bold

            macro , open-in-browser

            highlight all "---.*---" yellow
            highlight feedlist ".*(0/0))" black
            highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
            highlight article "(^Link:.*|^Date:.*)" default default
            highlight article "https?://[^ ]+" green default
            highlight article "^(Title):.*$" blue default
            highlight article "\\[[0-9][0-9]*\\]" magenta default bold
            highlight article "\\[image\\ [0-9]+\\]" green default bold
            highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
            highlight article ":.*\\(link\\)$" cyan default
            highlight article ":.*\\(image\\)$" blue default
            highlight article ":.*\\(embedded flash\\)$" magenta default
    '';
  };
}
