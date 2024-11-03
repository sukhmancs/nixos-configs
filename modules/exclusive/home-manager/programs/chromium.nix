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
  config = mkIf config.programs.chromium.enable {
    programs.chromium = {
      commandLineArgs = [
        "--enable-logging=stderr"
        "--password-store=gnome-libsecret"
        "--ozone-platform-hint=wayland"
        "--gtk-version=4"
        "--ignore-gpu-blocklist"
        "--enable-features=TouchpadOverscrollHistoryNavigation"
        "--enable-wayland-ime"
      ];
      extensions = [
        {
          # adguard
          id = "bgnkhhnnamicmpeenaelnjfhikgbkllg";
        }
        {
          # bypass paywalls
          id = "dcpihecpambacapedldabdbpakmachpb";
          updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        }
        {
          # dark reader
          id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          updateUrl = "https://clients2.google.com/service/update2/crx";
        }
      ];
    };
  };
}
