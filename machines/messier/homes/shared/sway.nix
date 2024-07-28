{pkgs, ...}: {
  config = {
    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      config = rec {
        modifier = "Mod4";
        # terminal = "${pkgs.foot}/bin/foot";
        # menu = "${pkgs.wofi}/bin/wofi --show drun";

        # startup = [
        #   {
        #     command = "${pkgs.autotiling}/bin/autotiling";
        #     always = true;
        #   }
        #   {
        #     command = "exec ${pkgs.blueman}/bin/blueman-applet";
        #     always = true;
        #   }
        # ];
        startup = [{command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY";}];

        bars = [];

        fonts = {
          names = ["Source Code Pro"];
          size = 10.0;
        };

        # gaps = {
        #   inner = 5;
        #   outer = 5;
        # };

        input = {
          # Input modules: $ man sway-input
          "type:touchpad" = {
            tap = "disabled";
            dwt = "enabled";
            scroll_method = "two_finger";
            middle_emulation = "enabled";
            natural_scroll = "enabled";
          };
          "type:keyboard" = {
            xkb_layout = "us";
            xkb_numlock = "enabled";
          };
        };

        defaultWorkspace = "workspace number 1";

        colors.focused = {
          background = "#999999";
          border = "#999999";
          childBorder = "#999999";
          indicator = "#212121";
          text = "#999999";
        };

        keybindings = {
          "${modifier}+Escape" = "exec swaymsg exit";
          #   "${modifier}+Return" = "exec ${terminal}";
          #   "${modifier}+space" = "exec ${menu}";
          #   "${modifier}+e" = "exec ${pkgs.pcmanfm}/bin/pcmanfm";
          #   "${modifier}+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";

          "${modifier}+r" = "reload";
          "${modifier}+q" = "kill";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+h" = "floating toggle";

          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";
          "${modifier}+Up" = "focus up";
          "${modifier}+Down" = "focus down";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Right" = "move right";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Down" = "move down";

          "Alt+Left" = "workspace prev_on_output";
          "Alt+Right" = "workspace next_on_output";

          "Alt+1" = "workspace number 1";
          "Alt+2" = "workspace number 2";
          "Alt+3" = "workspace number 3";

          "Alt+Shift+Left" = "move container to workspace prev, workspace prev";
          "Alt+Shift+Right" = "move container to workspace next, workspace next";

          "Alt+Shift+1" = "move container to workspace number 1";
          "Alt+Shift+2" = "move container to workspace number 2";
          "Alt+Shift+3" = "move container to workspace number 3";
          "Alt+Shift+4" = "move container to workspace number 4";
          "Alt+Shift+5" = "move container to workspace number 5";

          "Control+Up" = "resize shrink height 20px";
          "Control+Down" = "resize grow height 20px";
          "Control+Left" = "resize shrink width 20px";
          "Control+Right" = "resize grow width 20px";

          #   "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          #   "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
          #   "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
          #   "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
          #   "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

          #   "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U  5";
          #   "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
        };
      };
      extraConfig = ''
        set $opacity 0.8
        for_window [class=".*"] opacity 0.95
        for_window [app_id=".*"] opacity 0.95
        for_window [app_id="thunar"] opacity 0.95, floating disable
        for_window [app_id="foot"] opacity $opacity
        for_window [title="drun"] opacity $opacity
        # for_window [class="Emacs"] opacity $opacity
        for_window [app_id="pavucontrol"] floating enable, sticky
        # for_window [app_id=".blueman-manager-wrapped"] floating enable
        for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
      ''; # $ swaymsg -t get_tree or get_outputs
      extraSessionCommands = ''
        #export WLR_NO_HARDWARE_CURSORS="1";  # Needed for cursor in vm
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway
        export XDG_CURRENT_DESKTOP=sway
      '';
    };
  };
}