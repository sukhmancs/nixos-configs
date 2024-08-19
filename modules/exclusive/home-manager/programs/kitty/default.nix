{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  config = mkIf config.programs.kitty.enable {
    home.packages = [
      (
        pkgs.writeShellScriptBin "xterm" ''
          ${lib.getExe config.programs.kitty.package} "$@"
        ''
      )
    ];
    # I prefer to use ssh -M explicitly, thanks.
    xdg.configFile = {
      "kitty/ssh.conf".text = ''
        share_connections no
      '';

      "kitty/kitty.gif".source = ./kitty.gif;
    };
    xdg.mimeApps = {
      associations.added = {
        "x-scheme-handler/terminal" = "kitty.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/terminal" = "kitty.desktop";
      };
    };
    programs.kitty = {
      font = {
        name = "FiraCode Nerd Font";
        size = 12;
      };
      keybindings = {
        "ctrl+enter" = "send_text normal clone-in-kitty --type os-window\\r";
      };
      settings = {
        editor = "$EDITOR";
        shell_integration = "no-rc";
        scrollback_lines = 4000;
        scrollback_pager_history_size = 100000;
        window_padding_width = 15;
        foreground = "${colors.base05}";
        background = "${colors.base00}";
        selection_background = "${colors.base05}";
        selection_foreground = "${colors.base00}";
        url_color = "${colors.base0E}";
        cursor = "${colors.base05}";
        active_border_color = "${colors.base0A}";
        inactive_border_color = "${colors.base04}";
        active_tab_background = "${colors.base00}";
        active_tab_foreground = "${colors.base05}";
        inactive_tab_background = "${colors.base04}";
        inactive_tab_foreground = "${colors.base0E}";
        tab_bar_background = "${colors.base04}";
        color0 = "${colors.base00}";
        color1 = "${colors.base08}";
        color2 = "${colors.base0B}";
        color3 = "${colors.base0A}";
        color4 = "${colors.base0D}";
        color5 = "${colors.base06}";
        color6 = "${colors.base0F}";
        color7 = "${colors.base05}";
        color8 = "${colors.base0A}";
        color9 = "${colors.base08}";
        color10 = "${colors.base0B}";
        color11 = "${colors.base0A}";
        color12 = "${colors.base0D}";
        color13 = "${colors.base06}";
        color14 = "${colors.base0F}";
        color15 = "${colors.base03}";
        color16 = "${colors.base09}";
        color17 = "${colors.base08}";
        color18 = "${colors.base04}";
        color19 = "${colors.base07}";
        color20 = "${colors.base0E}";
        color21 = "${colors.base05}";
      };
    };
  };
}