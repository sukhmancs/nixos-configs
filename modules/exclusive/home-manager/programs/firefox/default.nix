{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf mkGraphicalService getExe;
  inherit (osConfig) modules;
in {
  config = mkIf config.programs.firefox.enable {
    programs.firefox = {
      profiles = {
        default = {
          id = 0;
          name = "Default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.search.region" = "US";
            "browser.search.isUS" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";
          };
          # extensions = [
          #   {
          #     # adguard
          #     id = "bgnkhhnnamicmpeenaelnjfhikgbkllg";
          #   }
          #   {
          #     # bypass paywalls
          #     id = "dcpihecpambacapedldabdbpakmachpb";
          #     updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
          #   }
          #   {
          #     # dark reader
          #     id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          #     updateUrl = "https://clients2.google.com/service/update2/crx";
          #   }
          # ];
          userChrome = builtins.readFile ./config/userChrome.css;
        };
      };
    };
  };
}
