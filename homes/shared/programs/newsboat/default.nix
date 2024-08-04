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
  tsp = ''${pkgs.lib.getExe' pkgs.taskspooler "ts"}'';
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

        color listnormal         cyan default
        color listfocus          black yellow standout bold
        color listnormal_unread  blue default
        color listfocus_unread   yellow default bold
        color info               red black bold
        color article            white default bold
        color background         default default
        color end-of-text-marker color8  default
        color hint-separator     default color8
        color hint-description   default color8
        color title              color14 color8

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
