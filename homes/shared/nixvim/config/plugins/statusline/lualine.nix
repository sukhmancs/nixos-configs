{ config, osConfig, ... }:
let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    globalstatus = true;
    disabledFiletypes = {
      statusline = [
        "dashboard"
        "alpha"
        "starter"
      ];
    };
    theme = {
      normal = {
        a = {
          bg = "#nil";
        };
        b = {
          bg = "nil";
        };
        c = {
          bg = "nil";
        };
        z = {
          bg = "nil";
        };
        y = {
          bg = "nil";
        };
      };
    };
    inactiveSections = {
      lualine_x = [
        "filename"
        "filetype"
      ];
    };
    sections = {
      lualine_a = [
        {
          name = "mode";
          fmt = "string.lower";
          color = {
            fg = "#${colors.base04}";
            bg = "nil";
          };
          separator.left = "";
          separator.right = "";
        }
      ];
      lualine_b = [
        {
          name = "branch";
          icon = "";
          color = {
            fg = "#${colors.base04}";
            bg = "nil";
          };
          separator.left = "";
          separator.right = "";
        }
        {
          name = "diff";
          separator.left = "";
          separator.right = "";
        }
      ];
      lualine_c = [
        {
          name = "diagnostic";
          extraConfig = {
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
          };
          color = {
            fg = "#${colors.base08}";
            bg = "nil";
          };
          separator.left = "";
          separator.right = "";
        }
      ];
      lualine_x = [ "" ];
      lualine_y = [
        {
          name = "filetype";
          extraConfig = {
            icon_only = true;
          };
          separator.left = "";
          separator.right = "";
        }
        {
          name = "filename";
          extraConfig = {
            symbols = {
              modified = "";
              readonly = "👁️";
              unnamed = "";
            };
          };
          color = {
            fg = "#${colors.base05}";
            bg = "nil";
          };
          separator.left = "";
          separator.right = "";
        }
      ];
      lualine_z = [
        {
          name = "location";
          color = {
            fg = "#${colors.base0B}";
            bg = "nil";
          };
          separator.left = "";
          separator.right = "";
        }
      ];
    };
  };
}
