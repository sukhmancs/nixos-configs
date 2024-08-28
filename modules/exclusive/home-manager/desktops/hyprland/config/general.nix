{ osConfig, ... }:
let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in
{
  wayland.windowManager.hyprland.settings = {
    general = {
      # gaps
      gaps_in = 4;
      gaps_out = 5;

      gaps_workspaces = 50;

      # border thickness
      border_size = 2;

      # Fallback colors
      "col.active_border" = "rgba(${colors.base0E}FF)";
      "col.inactive_border" = "rgba(${colors.base02}00)";

      resize_on_border = true;
      no_focus_fallback = true;
      layout = "dwindle";

      #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
      allow_tearing = true;
    };
  };
}
