# theme.nix
{config, ...}: let
  # colors = {
  #   primary = "#3498db";
  #   on_primary = "#ffffff";
  #   bg = "#ecf0f1";
  #   surface_container_low = "#bdc3c7";
  #   popover_radius = "8px";
  #   popover_padding = "16px";
  #   popover_border_color = "#95a5a6";
  #   border_width = "1px";
  #   border_color = "#7f8c8d";
  #   shadow_color = "rgba(0, 0, 0, 0.1)";
  #   radius = "4px";
  #   fg = "#2c3e50";
  #   spacing = "8px";
  #   capuchino = {
  #     primary = "#d35400";
  #     on_primary = "#ffffff";
  #     bg = "#f5e6cc";
  #     surface_container_low = "#e0c3a3";
  #     popover_radius = "8px";
  #     popover_padding = "16px";
  #     popover_border_color = "#c39c73";
  #     border_width = "1px";
  #     border_color = "#a67c52";
  #     shadow_color = "rgba(0, 0, 0, 0.1)";
  #     radius = "4px";
  #     fg = "#5e3c1b";
  #     spacing = "8px";
  #   };
  # };
  # theme = "capuchino"; # Change this to switch themes
  # selectedTheme =
  #   if theme == "capuchino"
  #   then colors.capuchino
  #   else colors;
  # Function to parse YAML files
  parseYaml = file: builtins.fromJSON (builtins.toJSON (builtins.fromTOML (builtins.readFile file)));

  colors = parseYaml config.modules.themes.colorsFile;

  # Generate SCSS content from the parsed colors
  scssContent = ''
    $scheme: "${colors.scheme}";
    $author: "${colors.author}";
    $base00: "${colors.base00}"; # base
    $base01: "${colors.base01}"; # mantle
    $base02: "${colors.base02}"; # surface0
    $base03: "${colors.base03}"; # surface1
    $base04: "${colors.base04}"; # surface2
    $base05: "${colors.base05}"; # text
    $base06: "${colors.base06}"; # rosewater
    $base07: "${colors.base07}"; # lavender
    $base08: "${colors.base08}"; # red
    $base09: "${colors.base09}"; # peach
    $base0A: "${colors.base0A}"; # yellow
    $base0B: "${colors.base0B}"; # green
    $base0C: "${colors.base0C}"; # teal
    $base0D: "${colors.base0D}"; # blue
    $base0E: "${colors.base0E}"; # mauve
    $base0F: "${colors.base0F}"; # flamingo
  '';
in {
  modules.themes.colorscheme = {
    name = "catppuccin-mocha";
  };

  variablesFile = builtins.toFile "variables.scss" scssContent;

  home.file.".config/ags/style/variables.scss".text = ''
    ${variablesFile}
  '';
}
