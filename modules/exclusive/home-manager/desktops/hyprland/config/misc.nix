{
  wayland.windowManager.hyprland.settings = {
    misc = {
      # layers_hog_mouse_focus = true; # Uncomment if needed
      focus_on_activate = true;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      # window swallowing
      enable_swallow = true; # hide windows that spawn other windows
      swallow_regex = "foot|thunar|nemo|wezterm"; # windows for which swallow is applied

      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      new_window_takes_over_fullscreen = 2;
      allow_session_lock_restore = true;
      initial_workspace_tracking = false;
      mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
      key_press_enables_dpms = true; # enable dpms on keyboard action
      disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
      # background_color = "rgba(1D1011FF)";
    };
  };
}
