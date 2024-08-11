{
  config,
  lib,
  pkgs,
  osConfig,
  inputs',
  ...
}: let
  inherit (lib) mkIf optionals;
in {
  config = mkIf config.programs.rofi.enable {
    programs.rofi = {
      theme = let
        inherit (osConfig.modules.themes) colors;
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        window = {
          transparency = "real";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          fullscreen = mkLiteral "false";
          width = mkLiteral "800px";
          x-offset = mkLiteral "0px";
          y-offset = mkLiteral "0px";
          enabled = mkLiteral "true";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border-radius = mkLiteral "20px";
          border = mkLiteral "4px";
          border-color = mkLiteral "#${colors.base02}";
          cursor = "default";
          background-color = mkLiteral "#${colors.base00}";
        };

        mainbox = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "30px";
          padding = mkLiteral "30px";
          background-color = mkLiteral "transparent";
          children = mkLiteral "[inputbar, message, listview]";
        };

        inputbar = {
          enabled = mkLiteral "true";
          # spacing = mkLiteral "0px";
          # margin = mkLiteral "0px 200px";
          # padding = mkLiteral "5px";
          border = mkLiteral "1px";
          border-radius = mkLiteral "100%";
          border-color = mkLiteral "#${colors.base02}";
          background-color = mkLiteral "#${colors.base02}";
          children = mkLiteral "[textbox-prompt-colon, entry]";
        };

        textbox-prompt-colon = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          padding = mkLiteral "12px 15px";
          border-radius = mkLiteral "100%";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#${colors.base0E}";
          str = " ";
        };

        entry = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          width = mkLiteral "250px";
          padding = mkLiteral "12px 16px";
          border-radius = mkLiteral "100%";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#${colors.base05}";
          cursor = mkLiteral "text";
          placeholder = mkLiteral "Search...";
          placeholder-color = mkLiteral "#${colors.base04}";
        };

        listview = {
          enabled = mkLiteral "true";
          columns = mkLiteral "2";
          lines = mkLiteral "10";
          cycle = mkLiteral "true";
          dynamic = mkLiteral "true";
          scrollbar = mkLiteral "false";
          layout = mkLiteral "vertical";
          reverse = mkLiteral "false";
          fixed-height = mkLiteral "true";
          fixed-columns = mkLiteral "true";
          spacing = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          cursor = mkLiteral "default";
        };

        element = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "5px";
          border = mkLiteral "0px";
          border-radius = mkLiteral "100%";
          # border-color = mkLiteral "gray/15%";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#${colors.base05}";
          cursor = mkLiteral "pointer";
        };

        # "element normal.active" = {
        #   background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
        #   text-color = mkLiteral "#19B466";
        # };

        # "element selected.normal" = {
        #   background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
        #   text-color = mkLiteral "#FF9030";
        # };

        # "element selected.active" = {
        #   background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
        #   text-color = mkLiteral "#EA5553";
        # };

        "element normal.normal" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "#${colors.base02}";
          text-color = mkLiteral "#${colors.base08}";
        };
        "element normal.active" = {
          background-color = mkLiteral "${colors.base02}";
          text-color = mkLiteral "${colors.base0E}";
        };
        "element selected.normal" = {
          background-color = mkLiteral "#${colors.base02}";
          text-color = mkLiteral "#${colors.base05}";
        };
        "element selected.urgent" = {
          background-color = mkLiteral "#${colors.base02}";
          text-color = mkLiteral "#${colors.base08}";
        };
        "element selected.active" = {
          background-color = mkLiteral "#${colors.base02}";
          text-color = mkLiteral "#${colors.base0E}";

          "element-icon" = {
            background-color = mkLiteral "transparent";
            size = mkLiteral "24px";
            cursor = mkLiteral "inherit";
          };

          "element-text" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "${colors.base05}";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };

          "mode-switcher" = {
            enabled = mkLiteral "true";
            expand = mkLiteral "false";
            spacing = mkLiteral "10px";
            text-color = mkLiteral "#${colors.base05}";
            # margin = mkLiteral "0px 200px";
            # padding = mkLiteral "12px";
            # border-radius = mkLiteral "100%";
            # background-color = mkLiteral "#2E343B";
          };

          button = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "${colors.base05}";
            cursor = mkLiteral "pointer";
          };

          "button selected" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "${colors.base0E}";
          };

          "error-message" = {
            padding = mkLiteral "20px";
            background-color = mkLiteral "#${colors.base00}";
            text-color = mkLiteral "${colors.base08}";
          };

          message = {
            padding = mkLiteral "0px";
            background-color = mkLiteral "${colors.base00}";
            text-color = mkLiteral "${colors.base0E}";
          };

          textbox = {
            padding = mkLiteral "0px";
            border-radius = mkLiteral "0px";
            background-color = mkLiteral "${colors.base00}";
            text-color = mkLiteral "${colors.base0E}";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };

          # "*" = {
          #   background = mkLiteral "#${colors.base02}";
          #   background-alt = mkLiteral "#${colors.base02}";
          #   foreground = mkLiteral "#${colors.base05}";
          #   selected = mkLiteral "#${colors.base00}";
          #   active = mkLiteral "#${colors.base0D}";
          #   urgent = mkLiteral "#${colors.base00}";
          # };
          # "window" = {
          #   transparency = "real";
          #   location = mkLiteral "center";
          #   anchor = mkLiteral "center";
          #   fullscreen = mkLiteral "false";
          #   width = mkLiteral "600px";
          #   x-offset = mkLiteral "0px";
          #   y-offset = mkLiteral "0px";
          #   enabled = mkLiteral "true";
          #   border-radius = mkLiteral "20px";
          #   border = mkLiteral "4px";
          #   border-color = mkLiteral "#${colors.base02}";
          #   cursor = "default";
          #   background-color = mkLiteral "@background";
          # };
          # "mainbox" = {
          #   enabled = true;
          #   spacing = mkLiteral "0px";
          #   background-color = mkLiteral "transparent";
          #   orientation = mkLiteral "vertical";
          #   children = mkLiteral "[inputbar,listbox]";
          # };
          # "listbox" = {
          #   spacing = mkLiteral "10px";
          #   padding = mkLiteral "10px 10px 10px 15px";
          #   background-color = mkLiteral "transparent";
          #   orientation = mkLiteral "vertical";
          #   children = mkLiteral "[message,listview]";
          # };
          # "inputbar" = {
          #   enabled = true;
          #   spacing = mkLiteral "10px";
          #   padding = mkLiteral "30px 20px 30px 20px";
          #   background-color = mkLiteral "@selected";
          #   text-color = mkLiteral "@foreground";
          #   orientation = mkLiteral "horizontal";
          #   children = mkLiteral "[prompt,entry]";
          # };
          # "entry" = {
          #   enabled = true;
          #   expand = true;
          #   width = mkLiteral "300px";
          #   padding = mkLiteral "12px 15px";
          #   border-radius = mkLiteral "15px";
          #   background-color = mkLiteral "@background-alt";
          #   text-color = mkLiteral "inherit";
          #   cursor = mkLiteral "text";
          #   placeholder = "Search";
          #   placeholder-color = mkLiteral "inherit";
          # };
          # "prompt" = {
          #   width = mkLiteral "64px";
          #   font = "Iosevka Nerd Font 13";
          #   padding = mkLiteral "10px 20px 10px 20px";
          #   border-radius = mkLiteral "15px";
          #   background-color = mkLiteral "@background-alt";
          #   text-color = mkLiteral "inherit";
          #   cursor = mkLiteral "pointer";
          # };
          # "mode-switcher" = {
          #   enabled = true;
          #   spacing = mkLiteral "10px";
          #   background-color = mkLiteral "transparent";
          #   text-color = mkLiteral "@foreground";
          # };
          # "button" = {
          #   width = mkLiteral "48px";
          #   font = "Iosevka Nerd Font 14";
          #   padding = mkLiteral "8px 5px 8px 8px";
          #   border-radius = mkLiteral "15px";
          #   background-color = mkLiteral "@background-alt";
          #   text-color = mkLiteral "inherit";
          #   cursor = mkLiteral "pointer";
          # };
          # "button selected" = {
          #   background-color = mkLiteral "@selected";
          #   text-color = mkLiteral "@foreground";
          # };
          # "listview" = {
          #   enabled = true;
          #   columns = 2;
          #   lines = 7;
          #   cycle = true;
          #   dynamic = true;
          #   scrollbar = false;
          #   layout = mkLiteral "vertical";
          #   reverse = false;
          #   fixed-height = true;
          #   fixed-columns = false;
          #   spacing = mkLiteral "5px";
          #   background-color = mkLiteral "transparent";
          #   text-color = mkLiteral "@foreground";
          #   cursor = mkLiteral "default";
          # };
          # "element" = {
          #   enabled = true;
          #   spacing = mkLiteral "15px";
          #   padding = mkLiteral "7px";
          #   border-radius = mkLiteral "100%";
          #   background-color = mkLiteral "transparent";
          #   text-color = mkLiteral "@foreground";
          #   cursor = mkLiteral "pointer";
          # };
          # "element normal.normal" = {
          #   background-color = mkLiteral "inherit";
          #   text-color = mkLiteral "inherit";
          # };
          # "element normal.urgent" = {
          #   background-color = mkLiteral "@urgent";
          #   text-color = mkLiteral "@foreground";
          # };
          # "element normal.active" = {
          #   background-color = mkLiteral "@background";
          #   text-color = mkLiteral "@active";
          # };
          # "element selected.normal" = {
          #   background-color = mkLiteral "@selected";
          #   text-color = mkLiteral "@foreground";
          # };
          # "element selected.urgent" = {
          #   background-color = mkLiteral "@urgent";
          #   text-color = mkLiteral "@foreground";
          # };
          # "element selected.active" = {
          #   background-color = mkLiteral "@urgent";
          #   text-color = mkLiteral "@active";
          # };
          # "element-icon" = {
          #   background-color = mkLiteral "transparent";
          #   text-color = mkLiteral "inherit";
          #   size = mkLiteral "32px";
          #   cursor = mkLiteral "inherit";
          # };
          # "element-text" = {
          #   background-color = mkLiteral "transparent";
          #   text-color = mkLiteral "inherit";
          #   cursor = mkLiteral "inherit";
          #   vertical-align = mkLiteral "0.5";
          #   horizontal-align = mkLiteral "0.0";
          # };
          # "message" = {background-color = mkLiteral "transparent";};
          # "textbox" = {
          #   padding = mkLiteral "12px";
          #   border-radius = mkLiteral "100%";
          #   background-color = mkLiteral "@background-alt";
          #   text-color = mkLiteral "@foreground";
          #   vertical-align = mkLiteral "0.5";
          #   horizontal-align = mkLiteral "0.0";
          # };
          # "error-message" = {
          #   padding = mkLiteral "12px";
          #   border-radius = mkLiteral "20px";
          #   background-color = mkLiteral "@background";
          #   text-color = mkLiteral "@foreground";
          # };
        };
      };
    };
  };
}
