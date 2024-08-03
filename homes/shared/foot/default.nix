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
    programs.foot = {
      enable = true;
      # package = inputs'.nyxpkgs.packages.foot-transparent;
      server.enable = false;
      settings = {
        main = {
          app-id = "foot";
          title = "foot";
          locked-title = "no";
          term = "xterm-256color";
          # pad = "16x16 center";
          pad = "12x21 center";
          shell = "zsh";
          resize-delay-ms = 100;
          word-delimiters = ",│`|:\"'()[]{}<>";

          # notifications
          notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
          selection-target = "clipboard";

          # font and font rendering
          dpi-aware = true; # this looks more readable on a laptop, but it's unreasonably large
          font = "Iosevka Nerd Font:size=14";
          font-bold = "Iosevka Nerd Font:size=14";
          # vertical-letter-offset = "-0.90";
          vertical-letter-offset = "-0.75";
          bold-text-in-bright = "no";
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

        # colors = import ./presets/colors.nix {inherit colors;} // {alpha = "0.85";};
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
          bright7 = "${colors.base07}";
          foreground = "${colors.base05}";
          regular0 = "${colors.base03}";
          regular1 = "${colors.base08}";
          regular2 = "${colors.base0B}";
          regular3 = "${colors.base0A}";
          regular4 = "${colors.base0D}";
          regular5 = "${colors.base0F}";
          regular6 = "${colors.base0C}";
          regular7 = "${colors.base06}";
        };
      };
    };
  };
}
