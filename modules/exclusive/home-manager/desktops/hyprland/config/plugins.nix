{osConfig, ...}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  wayland.windowManager.hyprland.settings = {
    plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "rgb(${colors.base00})";
        workspace_method = "first 1";

        enable_gesture = false;
        gesture_distance = 300;
        gesture_positive = false;
      };
    };
  };
}
