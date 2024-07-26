{osConfig, ...}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      # sensitivity of the mouse cursor
      sensitivity = 0.8;

      # gaps
      gaps_in = 4;
      gaps_out = 8;

      gaps_workspaces = 50;

      # border thiccness
      border_size = 2;

      # Fallback colors
      # "col.active_border" = "rgba(0DB7D4FF)";
      # "col.inactive_border" = "rgba(31313600)";

      "col.active_border" = "0x#${colors.base0E}";
      "col.inactive_border" = "0x#${colors.base02}";

      resize_on_border = true;
      no_focus_fallback = true;
      layout = "dwindle";

      #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
      allow_tearing = true; # This just allows the `immediate` window rule to work

      # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      apply_sens_to_raw = 0;
    };
  };
}
