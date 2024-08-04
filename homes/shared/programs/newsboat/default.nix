{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe;

  mpv = "${getExe pkgs.mpv}";
  glow = "${getExe pkgs.glow}";
  pandoc = "${getExe pkgs.pandoc}";
  urs = "${getExe pkgs.urlscan}";
  tsp = "${getExe pkgs.tsduck}";
  lynx = "${getExe pkgs.lynx}";
  yt = "${getExe pkgs.yt-dlp}";
  wlc = "${getExe pkgs.wl-clipboard}";
in {
  config = {
    home.packages = with pkgs; [
      (import ./scripts/rofiHandler.nix {inherit pkgs;})
    ];

    programs.newsboat = {
      enable = true;
      autoReload = true;

      inherit ((import ./urls.nix)) urls;

      extraConfig = ''
        # error-log /dev/null
        # download-full-page yes
        # download-retries 3
        # cookie-cache ~/.cache/newsboat/cookies.txt
        # auto-reload yes
        # max-items 0
        # scrolloff 999
        # reload-threads 100
        # bind-key j down
        # bind-key k up
        # bind-key j next articlelist
        # bind-key k prev articlelist
        # bind-key J next-feed articlelist
        # bind-key K prev-feed articlelist
        # bind-key G end
        # bind-key g home
        # bind-key d pagedown
        # bind-key u pageup
        # bind-key l open
        # bind-key h quit
        # bind-key a toggle-article-read
        # bind-key n next-unread
        # bind-key N prev-unread
        # bind-key D pb-download
        # bind-key U show-urls
        # bind-key x pb-delete
        # color listnormal         color15 default
        # color listnormal_unread  color2  default
        # color listfocus_unread   color2  color0
        # color listfocus          default color0
        # color background         default default
        # color article            default default
        # color end-of-text-marker color8  default
        # color info               color4  color8
        # color hint-separator     default color8
        # color hint-description   default color8
        # color title              color14 color8
        # highlight article "^(Feed|Title|Author|Link|Date): .+" color4 default bold
        # highlight article "^(Feed|Title|Author|Link|Date):" color14 default bold
        # highlight article "\\((link|image|video)\\)" color8 default
        # highlight article "https?://[^ ]+" color4 default
        # highlight article "\[[0-9]+\]" color6 default bold
        # user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
        # html-renderer "${pandoc} --from=html -t markdown_github-raw_html"
        # pager "${glow} --pager --width 72"
        # # macros
        # macro v set browser "${mpv} %u" ; open-in-browser ; set browser "firefox %u" -- "Open video on mpv"
        # macro , open-in-browser




        #show-read-feeds no
        auto-reload yes

        external-url-viewer "${urs} -dc -r 'firefox {}'"

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

        browser "firefox %u"
        macro , open-in-browser
        html-renderer "${pandoc} --from=html -t markdown_github-raw_html"
        pager "${glow} --pager --width 72"
        macro r set browser "rofiHandler %u" ; open-in-browser ; set browser "firefox %u"
        macro t set browser "firefox %u" ; open-in-browser ; set browser "firefox %u"
        macro v set browser "setsid -f mpv" ; open-in-browser ; set browser "firefox %u"
        macro c set browser "echo %u | wl-copy && wl-copy --clear" ; open-in-browser ; set browser "firefox %u"
        macro a set browser "${tsp} ${yt} --embed-metadata -xic -f bestaudio/best --restrict-filenames" ; open-in-browser ; set browser "firefox %u"
        macro w set browser "${lynx} -anonymous -accept_all_cookies" ; open-in-browser ; set browser "firefox %u"

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
  };
}
