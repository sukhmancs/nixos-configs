{
  urls = [
    # Weekly NixOS news and some other stuff
    {
      title = "NixOS Weekly";
      tags = ["news" "twitter"];
      url = "https://weekly.nixos.org/feeds/all.rss.xml";
    }
    # https://hackaday.com/blog/feed/
    {
      title = "Hacker News";
      url = "https://hnrss.org/newest";
      tags = ["tech"];
    }
    {
      title = "Hacker News Daily";
      url = "https://www.daemonology.net/hn-daily/index.rss";
      tags = ["tech"];
    }
    # Reddit
    {
      title = "/r/neovim";
      url = "https://www.reddit.com/r/neovim/.rss";
      tags = ["neovim" "reddit"];
    }
    {
      title = "/r/unixporn";
      url = "https://www.reddit.com/r/unixporn/.rss";
      tags = ["unix" "ricing" "style"];
    }
    # Computerphile
    {
      title = "Computerphile";
      url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA";
      tags = ["tech" "youtube"];
    }
    # Security Blogs
    {
      title = "Krebson Security";
      url = "https://krebsonsecurity.com/feed/";
      tags = ["tech" "security"];
    }

    {
      title = "Alex Williamson Security Blog";
      url = "https://rss.app/feeds/2DNE7VXqTCz48R02.xml";
      tags = ["tech" "security"];
    }

    {
      title = "The Register";
      url = "https://www.theregister.com/security/headlines.atom";
      tags = ["tech" "security"];
    }

    {
      title = "Schneier on Security";
      url = "https://www.schneier.com/feed/";
      tags = ["tech" "security"];
    }

    {
      title = "Troy Hunt";
      url = "https://www.troyhunt.com/feed/";
      tags = ["tech" "security"];
    }

    {url = "https://xeiaso.net/blog.rss";}
    {url = "https://grahamc.com/feed";}
    {url = "https://feeds.feedburner.com/ThePragmaticEngineer";}
    {url = "https://www.reddit.com/r/ExperiencedDevs/.rss";}
    {url = "https://news.ycombinator.com/rss";}
    {url = "https://programming.dev/feeds/local.xml?sort=Active";}
    {url = "https://programming.dev/feeds/c/functional_programming.xml?sort=Active";}
    {url = "https://programming.dev/feeds/c/linux.xml?sort=Active";}
    {url = "https://programming.dev/feeds/c/experienced_devs.xml?sort=Active";}
    {url = "https://programming.dev/feeds/c/nix.xml?sort=Active";}
    {url = "https://programming.dev/feeds/c/commandline.xml?sort=Active";}
    {url = "https://beehaw.org/feeds/c/technology.xml?sort=Active";}
    {url = "https://lobste.rs/rss";}
    {url = "https://kiszamolo.hu/feed";}
  ];
}
