{
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  programs.yazi.theme.manager = {
    cwd = {fg = "#${colors.base0E}";};

    # Hovered
    hovered = {
      fg = "#${colors.base00}";
      bg = "#${colors.base0E}";
    };

    preview_hovered = {
      fg = "#${colors.base00}";
      bg = "#${colors.base0E}";
    };

    # Find
    find_keyword = {
      fg = "#${colors.base0A}";
      italic = true;
    };
    find_position = {
      fg = "#${colors.base0E}";
      bg = "reset";
      italic = true;
    };

    # Marker
    marker_selected = {
      fg = "#${colors.base0B}";
      # bg = "#${colors.base0B}";
    };
    marker_copied = {
      fg = "light#${colors.base0A}";
      # bg = "light#${colors.base0A}";
    };
    marker_cut = {
      fg = "#${colors.base08}";
      # bg = "#${colors.base08}";
    };

    # Tab
    tab_active = {
      fg = "#${colors.base00}";
      bg = "#${colors.base0E}";
    };
    tab_inactive = {
      fg = "#${colors.base05}";
      bg = "#${colors.base03}";
    };
    tab_width = 1;

    # Border;
    border_symbol = "│";
    border_style = {fg = "#${colors.base0E}";};

    # Offset;
    folder_offset = [1 0 1 0];
    preview_offset = [1 1 1 1];

    # Highlighting;
    syntect_theme = "";
  };
}
