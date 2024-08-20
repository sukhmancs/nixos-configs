# Original code by NotAShelf - https://github.com/notashelf/nyx

{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkDefault;
in {
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  i18n = let
    defaultLocale = "en_CA.UTF-8";
    ca = "en_CA.UTF-8";
  in {
    inherit defaultLocale;

    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = ca;
      LC_IDENTIFICATION = ca;
      LC_MEASUREMENT = ca;
      LC_MONETARY = ca;
      LC_NAME = ca;
      LC_NUMERIC = ca;
      LC_PAPER = ca;
      LC_TELEPHONE = ca;
      LC_TIME = ca;
    };

    supportedLocales = mkDefault [
      "en_US.UTF-8/UTF-8"
      "en_CA.UTF-8/UTF-8"
    ];

    # Todo enable it
    # ime configuration
    # inputMethod = {
    #   enable = true;
    #   type = "fcitx5"; # Needed for fcitx5 to work in qt6
    #   fcitx5.addons = with pkgs; [
    #     fcitx5-gtk
    #     fcitx5-lua
    #     libsForQt5.fcitx5-qt

    #     # themes
    #     fcitx5-material-color
    #   ];
    # };
  };
}
