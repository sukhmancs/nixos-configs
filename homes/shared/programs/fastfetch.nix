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
            top = 3;
            left = 1;
            right = 5;
          };
        };
        display = {
          separator = "    ";
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
          # "break"
          # {
          #   type = "title";
          #   keyWidth = 10;
          #   keyColor = "inverse_";
          # }
          "break"
          {
            type = "os";
            key = "";
            keyColor = "inverse_";
            format = "{2}";
          }
          {
            type = "kernel";
            key = "";
            keyColor = "inverse_";
            format = "{1} {2}";
          }
          {
            type = "wm";
            key = "";
            keyColor = "inverse_";
          }
          {
            type = "de";
            key = "";
            keyColor = "inverse_";
          }
          {
            type = "terminal";
            key = "";
            keyColor = "inverse_";
          }
          {
            type = "shell";
            key = "";
            keyColor = "inverse_";
          }
          {
            type = "lm";
            key = "󰧨";
            keyColor = "inverse_";
          }
          {
            type = "colors";
            paddingLeft = 0;
            key = "󰮯";
            keyColor = "inverse_";
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
