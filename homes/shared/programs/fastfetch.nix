{
  pkgs,
  lib,
  ...
}: {
  config = {
    home = {
      packages = [pkgs.fastfetch];
    };

    xdg.configFile = {
      "fastfetch/config.jsonc".text = builtins.toJSON {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          source = "nixos_small";
          padding = {
            top = 2;
            left = 1;
            right = 1;
          };
        };
        display = {
          separator = "  ";
          size = {
            ndigits = 0;
            maxPrefix = "GB";
          };
          bar = {
            charElapsed = "=";
            charTotal = "-";
            width = 13;
          };
          disableLinewrap = true;
          brightColor = true;
        };
        modules = [
          "break"
          {
            type = "custom";
            format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}";
          }
          "break"
          {
            type = "title";
            keyWidth = 10;
          }
          "break"
          {
            type = "cpu";
            #          keyColor = "bright_cyan";
            format = "{1}";
            key = "  󰍛";
          }
          {
            type = "gpu";
            #          keyColor = "bright_cyan";
            key = "  󰾲";
            format = "{2}";
          }
          {
            type = "memory";
            #           keyColor = "bright_cyan";
            key = "  󰑭";
          }
          {
            type = "disk";
            key = "  󱥎";
            format = "{1} / {2} ({3})";
            folders = "/";
          }
          {
            type = "display";
            #           keyColor = "bright_cyan";
            key = "  󰍹";
          }
          {
            type = "os";
            key = "  ";
            format = "{2}";
          }
          {
            type = "kernel";
            key = "  ";
            format = "{1} {2}";
          }
          {
            type = "wm";
            key = "  ";
          }
          {
            type = "de";
            key = "  ";
          }
          {
            type = "terminal";
            key = "  ";
          }
          {
            type = "shell";
            key = "  ";
          }
          {
            type = "lm";
            key = "  󰧨";
          }
          {
            type = "terminalfont";
            #           keyColor = "bright_magenta";
            key = "  ";
          }
          {
            type = "command";
            #           keyColor = "bright_magenta";
            key = "  󰉼";
            text = "cat ~/.config/Kvantum/kvantum.kvconfig | grep theme | cut -d '=' -f 2";
          }
          {
            type = "icons";
            #           keyColor = "bright_magenta";
            key = "  󰀻";
          }
          {
            type = "cursor";
            key = "  󰆿";
            #           keyColor = "bright_magenta";
          }
          {
            type = "command";
            #           keyColor = "bright_magenta";
            key = "  󰆧";
            text = "(${lib.getExe' pkgs.nix "nix-store"} --query --requisites /run/current-system | wc -l | tr -d '\n') && echo ' (nix; /run/current-system)'";
          }
          {
            type = "uptime";
            #           keyColor = "bright_magenta";
            key = "  󰅐";
          }
          {
            type = "command";
            #           keyColor = "bright_magenta";
            key = "  󰃲";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            type = "colors";
            paddingLeft = 1;
            key = "  󰮯";
            symbol = "circle";
          }
          "break"
          {
            type = "custom";
            format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}";
          }
          "break"
        ];
      };
    };
  };
}