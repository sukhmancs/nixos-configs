{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  qtThemePackage = pkgs.catppuccin-kde.override {
    flavour = ["mocha"];
    accents = ["blue"];
    winDecStyles = ["modern"];
  };
in {
  config = mkIf config.qt.enable {
    home.packages = with pkgs; [
      # libraries and programs to ensure that qt applications load without issue
      # breeze-icons is added as a fallback
      libsForQt5.qt5ct
      kdePackages.qt6ct
      # kdePackages.breeze-icons

      # libraries to ensure that "gtk" platform theme works
      # as intended after the following PR:
      # <https://github.com/nix-community/home-manager/pull/5156>
      # libsForQt5.qtstyleplugins
      # qt6Packages.qt6gtk2

      # kvantum as a library and a program to theme qt applications
      # this added here, however, this will not have an effect
      # until QT_QPA_PLATFORMTHEME has been set appropriately
      # we still write the config files for kvantum below
      # but again, it is a no-op until the env var is set
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
    ];

    qt = {
      platformTheme.name = "qtct"; # just an override for QT_QPA_PLATFORMTHEME, takes “gtk”, “gnome”, “qtct” or “kde”
      style.name = "kvantum"; # just an override for QT_STYLE_OVERRIDE, takes “kvantum” or “fusion”
    };

    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT5_COMPAT = "0";
      CALIBRE_USE_DARK_PALETTE = "1";
      # QT_QPA_PLATFORMTHEME = "qt5ct:qt6ct";
    };

    xdg.configFile = {
      # write ~/.config/kdeglobals based on the kdeglobals file the user has specified
      # this option is a catch-all and not a set path because some programs specify different
      # paths inside their kdeglobals package
      "kdeglobals".source = "${qtThemePackage}/share/color-schemes/CatppuccinMochaBlue.colors";

      # Kvantum configuration files
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=default
      '';

      # Kvantum theme files
      "Kvantum/default/default.kvconfig" = {
        text = import ./default/default.nix {
          inherit osConfig pkgs;
        };
      };

      "Kvantum/default/default.svg" = {
        source = ./default/default.svg;
      };
    };
  };
}
