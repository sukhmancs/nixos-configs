{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  config = mkIf config.programs.zathura.enable {
    # xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
    #   hash = "sha256-POxMpm77Pd0qywy/jYzZBXF/uAKHSQ0hwtXD4wl8S2Q=";
    # };
    #TODO: Hash colors scheme is not being detected
    # xdg.configFile."zathura/custom-theme" = {
    #   text = import ./custom-theme.nix {inherit osConfig;};
    # };

    programs.zathura = {
      # extraConfig = "include custom-theme";

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

        default-fg = "#${colors.base05}";
        default-bg = "#${colors.base02}";

        completion-bg = "#${colors.base00}";
        completion-fg = "#${colors.base05}";
        completion-highlight-bg = "#${colors.base03}";
        completion-highlight-fg = "#${colors.base05}";
        completion-group-bg = "#${colors.base00}";
        completion-group-fg = "#${colors.base07}";

        statusbar-fg = "#${colors.base05}";
        statusbar-bg = "#${colors.base02}";

        notification-bg = "#${colors.base02}";
        notification-fg = "#${colors.base05}";
        notification-error-bg = "#${colors.base02}";
        notification-error-fg = "#${colors.base08}";
        notification-warning-bg = "#${colors.base02}";
        notification-warning-fg = "#${colors.base0A}";

        inputbar-fg = "#${colors.base05}";
        inputbar-bg = "#${colors.base02}";

        recolor = "true";
        recolor-lightcolor = "#${colors.base01}";
        recolor-darkcolor = "#${colors.base05}";

        index-fg = "#${colors.base05}";
        index-bg = "#${colors.base01}";
        index-active-fg = "#${colors.base05}";
        index-active-bg = "#${colors.base02}";

        render-loading-bg = "#${colors.base01}";
        render-loading-fg = "#${colors.base05}";

        highlight-color = "#${colors.base00}";
        highlight-fg = "#${colors.base0F}";
        highlight-active-color = "#${colors.base0F}";
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
