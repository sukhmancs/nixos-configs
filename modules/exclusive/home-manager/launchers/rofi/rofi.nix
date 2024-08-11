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
          transparency = mkLiteral "real";
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
          cursor = mkLiteral "default";
          background-color = mkLiteral "#22272C";
        };

        mainbox = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "25px";
          padding = mkLiteral "50px";
          background-color = mkLiteral "transparent";
          children = mkLiteral "[inputbar, message, listview, mode-switcher]";
        };

        inputbar = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "0px";
          margin = mkLiteral "0px 200px";
          padding = mkLiteral "5px";
          border = mkLiteral "1px";
          border-radius = mkLiteral "100%";
          border-color = mkLiteral "gray/25%";
          background-color = mkLiteral "transparent";
          children = mkLiteral "[textbox-prompt-colon, entry]";
        };

        textbox-prompt-colon = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          padding = mkLiteral "8px 11px";
          border-radius = mkLiteral "100%";
          background-color = mkLiteral "white";
          text-color = mkLiteral "black";
          str = mkLiteral "";
        };

        entry = {
          enabled = mkLiteral "true";
          padding = mkLiteral "8px 12px";
          border = mkLiteral "0px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "white";
          cursor = mkLiteral "text";
          placeholder = mkLiteral "Search...";
          placeholder-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
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
          border-color = mkLiteral "gray/15%";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "gray";
          cursor = mkLiteral "pointer";
        };

        "element normal.active" = {
          background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
          text-color = mkLiteral "#19B466";
        };

        "element selected.normal" = {
          background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
          text-color = mkLiteral "#FF9030";
        };

        "element selected.active" = {
          background-image = mkLiteral "linear-gradient(to right, #4C4F52, #2E343B)";
          text-color = mkLiteral "#EA5553";
        };

        "element-icon" = {
          background-color = mkLiteral "transparent";
          size = mkLiteral "24px";
          cursor = mkLiteral "inherit";
        };

        "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };

        "mode-switcher" = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          spacing = mkLiteral "0px";
          margin = mkLiteral "0px 200px";
          padding = mkLiteral "12px";
          border-radius = mkLiteral "100%";
          background-color = mkLiteral "#2E343B";
        };

        button = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "white";
          cursor = mkLiteral "pointer";
        };

        "button selected" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "#FF9030";
        };

        "error-message" = {
          padding = mkLiteral "20px";
          background-color = mkLiteral "#22272C";
          text-color = mkLiteral "white";
        };

        message = {
          padding = mkLiteral "0px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "#FF9030";
        };

        textbox = {
          padding = mkLiteral "0px";
          border-radius = mkLiteral "0px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
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
}
