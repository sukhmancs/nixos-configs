#
# Zathura - A highly customizable and functional document viewer.
#
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
    programs.zathura = {
      options = {
        font = "SF Pro Text 15"; # Sets the font used in the UI to SF Pro Text with size 15.
        selection-clipboard = "clipboard"; # Enables copying selected text to the clipboard.
        adjust-open = "best-fit"; # Adjusts the document to fit the window when opened.
        pages-per-row = "1"; # Sets the number of pages displayed per row to 1.
        scroll-page-aware = "true"; # Enables page-aware scrolling, stopping at page boundaries.
        scroll-full-overlap = "0.01"; # Sets the overlap when scrolling a full page to 1% of the page height.
        scroll-step = "100"; # Sets the number of pixels to scroll with each step.
        smooth-scroll = true; # Enables smooth scrolling.
        zoom-min = "10"; # Sets the minimum zoom level to 10%.
        guioptions = "none"; # Disables additional GUI elements.
        statusbar-h-padding = "0"; # Sets horizontal padding of the status bar to 0.
        statusbar-v-padding = "0"; # Sets vertical padding of the status bar to 0.
        page-padding = "1"; # Sets padding between pages to 1 pixel.

        default-fg = "#${colors.base05}"; # Sets the default foreground color.
        default-bg = "#${colors.base02}"; # Sets the default background color.

        completion-bg = "#${colors.base00}"; # Sets the background color of the completion menu.
        completion-fg = "#${colors.base05}"; # Sets the foreground color of the completion menu.
        completion-highlight-bg = "#${colors.base03}"; # Sets the background color of the highlighted item in the completion menu.
        completion-highlight-fg = "#${colors.base05}"; # Sets the foreground color of the highlighted item in the completion menu.
        completion-group-bg = "#${colors.base00}"; # Sets the background color of the group titles in the completion menu.
        completion-group-fg = "#${colors.base07}"; # Sets the foreground color of the group titles in the completion menu.

        statusbar-fg = "#${colors.base05}"; # Sets the foreground color of the status bar.
        statusbar-bg = "#${colors.base02}"; # Sets the background color of the status bar.

        notification-bg = "#${colors.base02}"; # Sets the background color of notifications.
        notification-fg = "#${colors.base05}"; # Sets the foreground color of notifications.
        notification-error-bg = "#${colors.base02}"; # Sets the background color of error notifications.
        notification-error-fg = "#${colors.base08}"; # Sets the foreground color of error notifications.
        notification-warning-bg = "#${colors.base02}"; # Sets the background color of warning notifications.
        notification-warning-fg = "#${colors.base0A}"; # Sets the foreground color of warning notifications.

        inputbar-fg = "#${colors.base05}"; # Sets the foreground color of the input bar.
        inputbar-bg = "#${colors.base02}"; # Sets the background color of the input bar.

        recolor = "true"; # Enables recoloring of documents.
        recolor-lightcolor = "#${colors.base02}"; # Sets the light color used for recoloring.
        recolor-darkcolor = "#${colors.base05}"; # Sets the dark color used for recoloring.

        index-fg = "#${colors.base05}"; # Sets the foreground color of the index.
        index-bg = "#${colors.base01}"; # Sets the background color of the index.
        index-active-fg = "#${colors.base05}"; # Sets the foreground color of the active item in the index.
        index-active-bg = "#${colors.base02}"; # Sets the background color of the active item in the index.

        render-loading-bg = "#${colors.base01}"; # Sets the background color while rendering/loading.
        render-loading-fg = "#${colors.base05}"; # Sets the foreground color while rendering/loading.

        highlight-color = "#${colors.base00}"; # Sets the color used for highlights.
        highlight-fg = "#${colors.base0F}"; # Sets the foreground color of highlighted text.
        highlight-active-color = "#${colors.base0F}"; # Sets the color of active highlights.
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

        # Custom mappings for fullscreen mode.
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
