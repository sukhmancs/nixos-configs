{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  # qtThemePackage = pkgs.catppuccin-kde.override {
  #   flavour = ["mocha"];
  #   accents = ["blue"];
  #   winDecStyles = ["modern"];
  # };

  # Define the color scheme
  customColors = {
    background = "#1e1e1e";
    foreground = "#cdd6f4";
    accent = "#cba6f7";
  };
  # Create the Kvantum configuration file content
  kvantumConfig = ''
    [General]
    theme=default
    [Applications]
    default=qt5ct, org.kde.dolphin, org.kde.kalendar, org.qbittorrent.qBittorrent, hyprland-share-picker, dolphin-emu, Nextcloud, nextcloud, cantata, org.kde.kid3-qt
  '';
  # kvantumConfig = ''
  #   [ColorEffects:Disabled]
  #   Color=112,111,110
  #   ColorAmount=0
  #   ColorEffect=0
  #   ContrastAmount=0.65
  #   ContrastEffect=1
  #   IntensityAmount=0.1
  #   IntensityEffect=0
  #   [ColorEffects:Inactive]
  #   ChangeSelectionColor=false
  #   Color=112,111,110
  #   ColorAmount=0.025
  #   ColorEffect=2
  #   ContrastAmount=0.1
  #   ContrastEffect=2
  #   Enable=true
  #   IntensityAmount=0
  #   IntensityEffect=0
  #   [Colors:Button]
  #   BackgroundAlternate=102,102,105
  #   BackgroundNormal=102,102,105
  #   DecorationFocus=170,170,170
  #   DecorationHover=150,150,150
  #   ForegroundActive=255,128,224
  #   ForegroundInactive=160,160,160
  #   ForegroundLink=46,184,230
  #   ForegroundNegative=240,1,1
  #   ForegroundNeutral=255,221,0
  #   ForegroundNormal=255,255,255
  #   ForegroundPositive=128,255,128
  #   ForegroundVisited=255,102,102
  #   [Colors:Selection]
  #   BackgroundAlternate=195,195,198
  #   BackgroundNormal=195,195,198
  #   DecorationFocus=170,170,170
  #   DecorationHover=150,150,150
  #   ForegroundActive=255,128,224
  #   ForegroundInactive=160,160,160
  #   ForegroundLink=46,184,230
  #   ForegroundNegative=240,1,1
  #   ForegroundNeutral=255,221,0
  #   ForegroundNormal=0,0,0
  #   ForegroundPositive=128,255,128
  #   ForegroundVisited=255,102,102
  #   [Colors:Tooltip]
  #   BackgroundAlternate=0,0,0
  #   BackgroundNormal=0,0,0
  #   DecorationFocus=170,170,170
  #   DecorationHover=150,150,150
  #   ForegroundActive=255,128,224
  #   ForegroundInactive=225,225,225
  #   ForegroundLink=46,184,230
  #   ForegroundNegative=240,1,1
  #   ForegroundNeutral=255,221,0
  #   ForegroundNormal=255,255,255
  #   ForegroundPositive=128,255,128
  #   ForegroundVisited=255,102,102
  #   [Colors:View]
  #   BackgroundAlternate=50,50,50
  #   BackgroundNormal=40,40,40
  #   DecorationFocus=170,170,170
  #   DecorationHover=150,150,150
  #   ForegroundActive=255,128,224
  #   ForegroundInactive=160,160,160
  #   ForegroundLink=46,184,230
  #   ForegroundNegative=240,1,1
  #   ForegroundNeutral=255,221,0
  #   ForegroundNormal=255,255,255
  #   ForegroundPositive=128,255,128
  #   ForegroundVisited=255,102,102
  #   [Colors:Window]
  #   BackgroundAlternate=51,50,48
  #   BackgroundNormal=51,50,48
  #   DecorationFocus=170,170,170
  #   DecorationHover=150,150,150
  #   ForegroundActive=255,128,224
  #   ForegroundInactive=160,160,160
  #   ForegroundLink=46,184,230
  #   ForegroundNegative=240,1,1
  #   ForegroundNeutral=255,221,0
  #   ForegroundNormal=255,255,255
  #   ForegroundPositive=128,255,128
  #   ForegroundVisited=255,102,102
  #   [General]
  #   ColorScheme=KvMojave
  #   Name=KvMojave
  #   shadeSortColumn=true
  #   [KDE]
  #   contrast=0
  #   [WM]
  #   activeBackground=61,62,67
  #   activeBlend=59,60,65
  #   activeForeground=255,255,255
  #   inactiveBackground=61,62,67
  #   inactiveBlend=59,60,65
  #   inactiveForeground=150,150,150
  # '';
in {
  config = mkIf config.qt.enable {
    home.packages = with pkgs; [
      # libraries and programs to ensure that qt applications load without issue
      # breeze-icons is added as a fallback
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.breeze-icons

      # libraries to ensure that "gtk" platform theme works
      # as intended after the following PR:
      # <https://github.com/nix-community/home-manager/pull/5156>
      libsForQt5.qtstyleplugins
      qt6Packages.qt6gtk2

      # kvantum as a library and a program to theme qt applications
      # this added here, however, this will not have an effect
      # until QT_QPA_PLATFORMTHEME has been set appropriately
      # we still write the config files for kvantum below
      # but again, it is a no-op until the env var is set
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
    ];

    qt = {
      platformTheme.name = "qtct"; #"gtk"; # just an override for QT_QPA_PLATFORMTHEME, takes “gtk”, “gnome”, “qtct” or “kde”
      style.name = "kvantum"; # just an override for QT_STYLE_OVERRIDE, takes “kvantum” or “fusion”
      # style = {
      #   name = "Catppuccin-Mocha-Dark";
      #   package = pkgs.catppuccin-kde.override {
      #     flavour = ["mocha"];
      #     accents = ["blue"];
      #     winDecStyles = ["modern"];
      #   };
      # };
    };

    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT5_COMPAT = "0";
      CALIBRE_USE_DARK_PALETTE = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct:qt6ct";
    };

    xdg.configFile = {
      # write ~/.config/kdeglobals based on the kdeglobals file the user has specified
      # this option is a catch-all and not a set path because some programs specify different
      # paths inside their kdeglobals package
      # "kdeglobals".source = "${qtThemePackage}/share/color-schemes/CatppuccinMochaBlue.colors".source;

      "Kvantum/kvantum.kvconfig".text = kvantumConfig;

      "Kvantum/default/default.kvconfig" = {
        source = ./default/default.kvconfig;
      };

      # "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
      #   url = "${baseGhUrl}/main/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig";
      #   sha256 = "1f8xicnc5696g0a7wak749hf85ynfq16jyf4jjg4dad56y4csm6s";
      # };

      # "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
      #   url = "${baseGhUrl}/main/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg";
      #   sha256 = "0vys09k1jj8hv4ra4qvnrhwxhn48c2gxbxmagb3dyg7kywh49wvg";
      # };
    };

    # home.file.".config/kvantum/kvantum.kvconfig" = {
    #   text = kvantumConfig;
    # };

    # /*
    # home.packages = with pkgs;
    #   [
    #     libsForQt5.qt5ct
    #     breeze-icons

    #     # libraries to ensure that "gtk" platform theme works
    #     # as intended after the following PR:
    #     # <https://github.com/nix-community/home-manager/pull/5156>
    #     libsForQt5.qtstyleplugins
    #     qt6Packages.qt6gtk2

    #     # add theme package to path just in case
    #     cfg.qt.theme.package
    #   ]
    #   ++ optionals cfg.useKvantum [
    #     qt6Packages.qtstyleplugin-kvantum
    #     libsForQt5.qtstyleplugin-kvantum
    #   ];
    # */

    # home = {
    #   packages = with pkgs;
    #     mkMerge [
    #       [
    #         # libraries and programs to ensure that qt applications load without issue
    #         # breeze-icons is added as a fallback
    #         libsForQt5.qt5ct
    #         kdePackages.qt6ct
    #         kdePackages.breeze-icons
    #       ]

    #       (mkIf config.gtk.enable [
    #         # libraries to ensure that "gtk" platform theme works
    #         # as intended after the following PR:
    #         # <https://github.com/nix-community/home-manager/pull/5156>
    #         libsForQt5.qtstyleplugins
    #         qt6Packages.qt6gtk2
    #       ])

    #       [
    #         # kvantum as a library and a program to theme qt applications
    #         # this added here, however, this will not have an effect
    #         # until QT_QPA_PLATFORMTHEME has been set appropriately
    #         # we still write the config files for kvantum below
    #         # but again, it is a no-op until the env var is set
    #         qt6Packages.qtstyleplugin-kvantum
    #         libsForQt5.qtstyleplugin-kvantum
    #       ]
    #     ];

    #   sessionVariables = {
    #     # scaling - 1 means no scaling
    #     QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    #     # use wayland as the default backend, fallback to xcb if wayland is not available
    #     QT_QPA_PLATFORM = "wayland;xcb";

    #     # disable window decorations everywhere
    #     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    #     # remain backwards compatible with qt5
    #     DISABLE_QT5_COMPAT = "0";

    #     # tell calibre to use the dark theme, because the light one hurts my eyes
    #     CALIBRE_USE_DARK_PALETTE = "1";
    #   };
    # };

    # # write files required by KDE and kvantum
    # # those are not used if the user does not use KDE toolkits
    # # or kvantum respectively. we set those regardless
    # xdg.configFile = let
    #   baseGhUrl = "https://raw.githubusercontent.com/catppuccin/Kvantum";
    # in {
    #   # write ~/.config/kdeglobals based on the kdeglobals file the user has specified
    #   # this option is a catch-all and not a set path because some programs specify different
    #   # paths inside their kdeglobals package
    #   "kdeglobals".source = "${qtThemePackage}/share/color-schemes/CatppuccinMochaBlue.colors".source;

    #   "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    #     General.theme = "catppuccin";
    #     Applications.catppuccin = ''
    #       qt5ct, org.kde.dolphin, org.kde.kalendar, org.qbittorrent.qBittorrent, hyprland-share-picker, dolphin-emu, Nextcloud, nextcloud, cantata, org.kde.kid3-qt
    #     '';
    #   };

    #   "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
    #     url = "${baseGhUrl}/main/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.kvconfig";
    #     sha256 = "1f8xicnc5696g0a7wak749hf85ynfq16jyf4jjg4dad56y4csm6s";
    #   };

    #   "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
    #     url = "${baseGhUrl}/main/src/Catppuccin-Mocha-Blue/Catppuccin-Mocha-Blue.svg";
    #     sha256 = "0vys09k1jj8hv4ra4qvnrhwxhn48c2gxbxmagb3dyg7kywh49wvg";
    #   };
    # };
  };
}
