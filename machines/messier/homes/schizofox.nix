{
  self',
  inputs,
  osConfig,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  imports = [inputs.schizofox.homeManagerModule];
  config = {
    programs.schizofox = {
      enable = true;
      theme = {
        font = "Inter";
        colors = {
          background-darker = "${colors.base01}";
          background = "${colors.base00}";
          foreground = "${colors.base05}";
          primary = "${colors.base0E}";
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

      # security = {
      #   sanitizeOnShutdown.enable = false;
      #   sandbox = true;
      #   noSessionRestore = false;
      #   userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      # };

      misc = {
        drm.enable = true;
        disableWebgl = false;
        firefoxSync = false;
      };

      extensions = {
        simplefox.enable = true;
        darkreader.enable = true;
        extraExtensions = {
          "{1018e4d6-728f-4b20-ad56-37578a4de76b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/flagfox/latest.xpi";
          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
    };
  };
}
