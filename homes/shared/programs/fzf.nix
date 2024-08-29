{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  programs.fzf = {
    enable = true;
    defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type=d --hidden --exclude=.git";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f --hidden --exclude=.git";
    defaultOptions = [
      "--layout=reverse" # Top-first.
      "--exact" # Substring matching by default, `'`-quote for subsequence matching.
      "--bind=alt-p:toggle-preview,alt-a:select-all"
      "--multi"
      "--no-mouse"
      "--info=inline"

      # Style and widget layout
      "--ansi"
      "--with-nth=1.."
      "--pointer=' '"
      "--pointer=' '"
      "--header-first"
      "--border=rounded"
    ];

    colors = {
      "preview-bg" = "-1";
      "gutter" = "-1";
      "bg" = "-1";
      "bg+" = "-1";
      "fg" = "#${colors.base04}";
      "fg+" = "#${colors.base0E}";
      "hl" = "#${colors.base0A}";
      "hl+" = "#${colors.base0A}";
      "header" = "#${colors.base0E}";
      "info" = "#${colors.base0E}";
      "pointer" = "#${colors.base0C}";
      "marker" = "#${colors.base0C}";
      "prompt" = "#${colors.base0E}";
      "spinner" = "#${colors.base0C}";
      "preview-fg" = "#${colors.base0E}";
    };

    enableZshIntegration = false;
    enableBashIntegration = false;
  };
}
