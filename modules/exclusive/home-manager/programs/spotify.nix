#
# Spicetify - Spotify but with more spice
#
{
  osConfig,
  self',
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  sys = modules.home;
  prg = sys.programs;

  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  config = mkIf prg.spotify.enable {
    programs.spicetify = {
      enable = true;
      spotifyPackage = pkgs.spotify;
      enabledCustomApps = [
        spicePkgs.apps.reddit
        spicePkgs.apps.lyricsPlus
        spicePkgs.apps.newReleases
        # (self'.packages.library)
        # (self'.packages.stats)

        # {
        #   src = pkgs.fetchFromGitHub {
        #     owner = "hroland";
        #     repo = "spicetify-show-local-files";
        #     rev = "1bfd2fc80385b21ed6dd207b00a371065e53042e";
        #     hash = "sha256-neKR2WaZ1K10dZZ0nAKJJEHNS56o8vCpYpi+ZJYJ/gU=";
        #   };
        #   # name = "localFiles";
        # }
      ];

      theme = spicePkgs.themes.catppuccin; # dribbblish, catppuccin, comfy, turntable,  etc.

      # specify that we want to use our custom colorscheme
      colorScheme = "custom";

      # color definition for custom color scheme.
      customColorScheme = {
        # text = "#ebbcba";
        # subtext = "#F0F0F0";
        # sidebar-text = "#e0def4";
        # main = "#191724";
        # sidebar = "#2a2837";
        # player = "#191724";
        # card = "#191724";
        # shadow = "#1f1d2e";
        # selected-row = "#797979";
        # button = "#31748f";
        # button-active = "#31748f";
        # button-disabled = "#555169";
        # tab-active = "#ebbcba";
        # notification = "#1db954";
        # notification-error = "#eb6f92";
        # misc = "#6e6a86";

        text = "${colors.base0E}";
        subtext = "${colors.base05}";
        sidebar-text = "${colors.base06}";
        main = "${colors.base00}";
        sidebar = "${colors.base02}";
        player = "${colors.base00}";
        card = "${colors.base00}";
        shadow = "${colors.base01}";
        selected-row = "${colors.base04}";
        button = "${colors.base0F}";
        button-active = "${colors.base0F}";
        button-disabled = "${colors.base03}";
        tab-active = "${colors.base0E}";
        notification = "${colors.base0B}";
        notification-error = "${colors.base08}";
        misc = "${colors.base06}";
      };

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        playlistIcons
        lastfm
        #        genre
        historyShortcut
        bookmark
        fullAlbumDate
        groupSession
        popupLyrics
      ];
    };
  };
}
