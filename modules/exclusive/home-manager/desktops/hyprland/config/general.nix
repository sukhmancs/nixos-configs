{osConfig, ...}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
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

      resize_on_border = true; # resize windows by dragging the border
      no_focus_fallback = true; # focus on the window under the cursor if no window is focused
      layout = "dwindle";

      #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
      allow_tearing = true;
    };

    # render = {
    #   # disable explicit sync it causes window flickering on older nvidia cards
    #   explicit_sync = 0;
    #   explicit_sync_kms = 0;
    # };
  };
}
