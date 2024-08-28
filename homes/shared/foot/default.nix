{
  inputs',
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig.modules.themes) colors;
in {
  config = {
    home.packages = with pkgs; [
      libsixel
    ];

    home.sessionVariables.NIX_INSPECT_EXCLUDE = "foot kitty ncurses imagemagick";

    programs.foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          app-id = "foot";
          locked-title = "no";
          title = "foot";
          pad = "12x21 center";
          term = "xterm-256color";
          shell = "zsh";
          resize-delay-ms = 100;
          word-delimiters = ",│`|:\"'()[]{}<>";
          selection-target = "clipboard";
          dpi-aware = true;
          font = "Iosevka Nerd Font:size=9";
          font-bold = "Iosevka Nerd Font:size=9";
          vertical-letter-offset = "-0.75";
          bold-text-in-bright = "no";
        };

        desktop-notifications = {
          command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        };

        bell = {
          command = "notify-send bell";
          command-focused = "no";
          notify = "yes";
          urgent = "yes";
        };

        key-bindings = {
          show-urls-launch = "Control+Shift+u";
          unicode-input = "Control+Shift+i";
        };

        scrollback = {
          lines = 10000;
          multiplier = 3;
        };

        tweak = {
          font-monospace-warn = "no"; # reduces startup time
          sixel = "yes";
        };

        cursor = {
          beam-thickness = 2;
          style = "beam";
        };

        mouse = {
          hide-when-typing = "yes";
        };

        mouse-bindings = {
          primary-paste = "BTN_MIDDLE";
          select-begin = "BTN_LEFT";
          select-begin-block = "Control+BTN_LEFT";
          select-extend = "BTN_RIGHT";
          select-extend-character-wise = "Control+BTN_RIGHT";
          select-word = "BTN_LEFT-2";
          select-word-whitespace = "Control+BTN_LEFT-2";
          selection-override-modifiers = "Shift";
        };

        url = {
          launch = "xdg-open \${url}";
          label-letters = "sadfjklewcmpgh";
          osc8-underline = "url-mode";
          protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";
          uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
        };

        colors = {
          alpha = "0.85";
          background = "${colors.base00}";
          bright0 = "${colors.base04}";
          bright1 = "${colors.base08}";
          bright2 = "${colors.base0B}";
          bright3 = "${colors.base0A}";
          bright4 = "${colors.base0D}";
          bright5 = "${colors.base0F}";
          bright6 = "${colors.base0C}";
          bright7 = "${colors.base0E}";
          foreground = "${colors.base05}";
          regular0 = "${colors.base03}";
          regular1 = "${colors.base08}";
          regular2 = "${colors.base0B}";
          regular3 = "${colors.base0A}";
          regular4 = "${colors.base0D}";
          regular5 = "${colors.base0F}";
          regular6 = "${colors.base0C}";
          regular7 = "${colors.base0E}";
        };
      };
    };
  };
}
