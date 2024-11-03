{
  self',
  inputs,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  schizofoxStartpage = pkgs.callPackage ./schizofox-startpage {inherit osConfig;};
in {
  imports = [
    inputs.schizofox.homeManagerModule
  ];
  config = mkIf config.programs.firefox.enable {
    programs.schizofox = {
      enable = true;
      theme = {
        font = "Inter";
        colors = {
          background-darker = "${colors.base01}"; # "181825";
          background = "${colors.base00}"; # "1e1e2e";
          foreground = "${colors.base05}"; # "cdd6f4";
          primary = "${colors.base0E}"; # "cba6f7";
        };
      };

      settings = {
        "security.OCSP.enabled" = 1;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.addons" = false;
      };

      search = rec {
        defaultSearchEngine = "Searxng";
        removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "LibRedirect" "DuckDuckGo"];
        searxUrl = "https://search.xilain.dev";
        searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";
        addEngines = [
          {
            Name = "Searxng";
            Description = "Decentralized search engine";
            Alias = "sx";
            Method = "GET";
            URLTemplate = "${searxQuery}";
          }
        ];
      };

      security = {
        sanitizeOnShutdown = false;
        sandbox = true;
        noSessionRestore = false;
        userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      };

      misc = {
        drm.enable = true;
        disableWebgl = false;
        firefoxSync = true;
        startPageURL = "file://${schizofoxStartpage.outPath}/index.html";
      };
      # Schizofox also have default extensions: temporary-containers, localcdn-fork-of-decentraleyes, don-t-fuck-with-paste, clearurls, libredirect, etc
      extensions = {
        simplefox.enable = true;
        darkreader.enable = true;
        extraExtensions = {
          "cb-remover@search.mozilla.org".install_url = "https://addons.mozilla.org/firefox/downloads/latest/clickbait-remover-for-youtube/latest.xpi";
          "treestyletab@piro.sakura.ne.jp".install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          "2.0@disconnect.me".install_url = "https://addons.mozilla.org/firefox/downloads/latest/disconnect/latest.xpi";
          "adguardadblocker@adguard.com".install_url = "https://addons.mozilla.org/firefox/downloads/latest/adguard-adblocker/latest.xpi";
          # "extension@one-tab.com".install_url = "https://addons.mozilla.org/firefox/downloads/latest/onetab/latest.xpi";
          "browser-extension@anonaddy".install_url = "https://addons.mozilla.org/firefox/downloads/latest/addy_io/latest.xpi";
          #  "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          "{1018e4d6-728f-4b20-ad56-37578a4de76b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/flagfox/latest.xpi";
          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-nonstop/latest.xpi";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          "{5ca032f5-aaac-41f6-85eb-99ec4bfcf828}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/pesticide/latest.xpi";
        };
      };
    };
  };
}
