{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.programs.zathura.enable {
    xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
      hash = "sha256-POxMpm77Pd0qywy/jYzZBXF/uAKHSQ0hwtXD4wl8S2Q=";
    };

    programs.zathura = {
      extraConfig = "include catppuccin-mocha";

      options = {
        font = "Iosevka 15";
        selection-clipboard = "clipboard";
        adjust-open = "best-fit";
        pages-per-row = "1";
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "100";
        smooth-scroll = true;
        zoom-min = "10";
        guioptions = "none";
        statusbar-h-padding = "0";
        statusbar-v-padding = "0";
        page-padding = "1";
      };

      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        i = "recolor";
        p = "print";
        g = "goto top";
        "[fullscreen] u" = "scroll half-up";
        "[fullscreen] d" = "scroll half-down";
        "[fullscreen] D" = "toggle_page_mode";
        "[fullscreen] r" = "reload";
        "[fullscreen] R" = "rotate";
        "[fullscreen] K" = "zoom in";
        "[fullscreen] J" = "zoom out";
        "[fullscreen] i" = "recolor";
        "[fullscreen] p" = "print";
        "[fullscreen] g" = "goto top";
      };
    };
  };
}
