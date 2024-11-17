{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 20;

      # blur
      blur = {
        enabled = true;
        size = 14;
        passes = 4;
        new_optimizations = 1;
        xray = true;
        contrast = 1;
        brightness = 1;
        noise = 0.01;
        popups = true;
        popups_ignorealpha = 0.6;
        vibrancy = 0.2;
        special = true; # expensive, but looks cool
      };

      # shadow config
      shadow = {
        enabled = "yes";
        range = 20;
        offset = "0 2";
        render_power = 4;
        ignore_window = true;
        color = "rgb(${colors.base01})";
      };

      # Dim
      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0;
    };

    group = {
      # new windows in a group spawn after current or at group tail
      insert_after_current = true;
      # focus on the window that has just been moved out of the group
      focus_removed_window = true;

      "col.border_active" = "rgb(${colors.base0E})";
      "col.border_inactive" = "rgb(${colors.base02})";

      groupbar = {
        # groupbar stuff
        # this removes the ugly gradient around grouped windows - which sucks
        gradients = false;
        font_size = 14;

        # titles look ugly, and I usually know what I'm looking at
        render_titles = false;

        # scrolling in the groupbar changes group active window
        scrolling = true;
      };
    };

    animations = {
      enabled = true; # we want animations, half the reason why we're on Hyprland innit
      first_launch_animation = true; # fade in on first launch

      bezier = [
        "linear, 0, 0, 1, 1"
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92"
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "softAcDecel, 0.26, 0.26, 0.15, 1"
        "md2, 0.4, 0, 0.2, 1" # use with .2s duration
      ];

      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 3, md3_decel"
        "layersIn, 1, 3, menu_decel, slide"
        "layersOut, 1, 1.6, menu_accel"
        "fadeLayersIn, 1, 2, menu_decel"
        "fadeLayersOut, 1, 4.5, menu_accel"
        "workspaces, 1, 7, menu_decel, slide"
        "specialWorkspace, 1, 3, md3_decel, slidevert"
      ];
    };
  };
}
