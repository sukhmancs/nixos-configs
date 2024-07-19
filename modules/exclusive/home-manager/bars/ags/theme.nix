# theme.nix
let
  colors = {
    primary = "#3498db";
    on_primary = "#ffffff";
    bg = "#ecf0f1";
    surface_container_low = "#bdc3c7";
    popover_radius = "8px";
    popover_padding = "16px";
    popover_border_color = "#95a5a6";
    border_width = "1px";
    border_color = "#7f8c8d";
    shadow_color = "rgba(0, 0, 0, 0.1)";
    radius = "4px";
    fg = "#2c3e50";
    spacing = "8px";

    capuchino = {
      primary = "#d35400";
      on_primary = "#ffffff";
      bg = "#f5e6cc";
      surface_container_low = "#e0c3a3";
      popover_radius = "8px";
      popover_padding = "16px";
      popover_border_color = "#c39c73";
      border_width = "1px";
      border_color = "#a67c52";
      shadow_color = "rgba(0, 0, 0, 0.1)";
      radius = "4px";
      fg = "#5e3c1b";
      spacing = "8px";
    };
  };

  theme = "capuchino"; # Change this to switch themes

  selectedTheme =
    if theme == "capuchino"
    then colors.capuchino
    else colors;

  scssContent = ''
    $primary: ${selectedTheme.primary};
    $on_primary: ${selectedTheme.on_primary};
    $bg: ${selectedTheme.bg};
    $surface_container_low: ${selectedTheme.surface_container_low};
    $popover-radius: ${selectedTheme.popover_radius};
    $popover-padding: ${selectedTheme.popover_padding};
    $popover-border-color: ${selectedTheme.popover_border_color};
    $border-width: ${selectedTheme.border_width};
    $border-color: ${selectedTheme.border_color};
    $shadow-color: ${selectedTheme.shadow_color};
    $radius: ${selectedTheme.radius};
    $fg: ${selectedTheme.fg};
    $spacing: ${selectedTheme.spacing};
  '';
in
  builtins.toFile "variables.scss" scssContent
