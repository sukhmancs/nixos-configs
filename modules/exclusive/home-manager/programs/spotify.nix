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
      # enabledCustomApps = [
      #   spicePkgs.apps.reddit
      #   spicePkgs.apps.lyricsPlus
      #   spicePkgs.apps.newReleases
      #   # (self'.packages.library)
      #   # {src = self'.packages.stats;}
      # ];
      enabledCustomApps = with spicePkgs.apps; [
        reddit
        lyricsPlus
        newReleases
      ];

      theme = spicePkgs.themes.catppuccin; # dribbblish, catppuccin, comfy, turntable,  etc.

      # specify that we want to use our custom colorscheme
      colorScheme = "custom";

      # color definition for custom color scheme.
      customColorScheme = {
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
        tab-active = "${colors.base0F}";
        notification = "${colors.base0B}";
        notification-error = "${colors.base08}";
        misc = "${colors.base06}";
      };

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        playlistIcons
        oneko # cat follow cursor
        hidePodcasts
        adblock
        historyShortcut
        bookmark
        shuffle
        fullAlbumDate
        groupSession
        lastfm
        popupLyrics
      ];
    };
  };
}
