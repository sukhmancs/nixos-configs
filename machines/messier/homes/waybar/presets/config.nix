{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) optionalString primaryMonitor;
in {
  mainBar = {
    layer = "top";
    position = "left";
    # monitor configuration, kind of dirty since it assumes DP-1 is my main monitor
    # output = primaryMonitor osConfig; #builtins.elemAt monitors 0;
    width = 55;
    spacing = 6;
    margin-left = null;
    margin-top = 6;
    margin-bottom = 6;
    margin-right = 6;
    fixed-center = true;
    exclusive = true;
    modules-left = [
      "custom/search"
      # "group/info"
    ];
    modules-center = ["hyprland/workspaces"];
    modules-right = [
      # "group/info-right"
      # "battery"
      "group/network"
      "clock"
      "custom/lock"
    ];

    "hyprland/workspaces" = let
      hyprctl = config.wayland.windowManager.hyprland.package + "/bin/hyprctl";
    in {
      on-click = "activate";
      on-scroll-up = "${hyprctl} dispatch workspace m+1";
      on-scroll-down = "${hyprctl} dispatch workspace m-1";
      format = "{icon}";
      active-only = false;
      all-outputs = true;
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
        "6" = [];
        "7" = [];
        "8" = [];
      };
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
    };

    "custom/search" = {
      format = " ";
      tooltip = false;
      on-click = "${lib.getExe pkgs.killall} rofi || run-as-service $(rofi -show drun)";
    };

    "group/info" = {
      orientation = "inherit";
      drawer = {
        "transition-duration" = 500;
        "transition-left-to-right" = false;
      };
      modules = [
        "custom/dmark"
        "group/gcpu"
        "memory"
        "disk"
      ];
    };

    "group/info-right" = {
      orientation = "inherit";
      drawer = {
        "transition-duration" = 500;
        "transition-left-to-right" = false;
      };
      modules = [
        "custom/dmark-up"
        "pulseaudio"
        "backlight"
        # "bluetooth"
        "tray"
      ];
    };

    "group/network" = {
      orientation = "inherit";
      drawer = {
        "transition-duration" = 500;
        "transition-left-to-right" = true;
      };
      modules = [
        "network"
        "network#speed"
      ];
    };

    "custom/dmark" = {
      format = "";
      tooltip = false;
    };

    "custom/dmark-up" = {
      format = "";
      tooltip = false;
    };

    "group/gcpu" = {
      orientation = "inherit";
      modules = [
        "custom/cpu-icon"
        "cpu"
      ];
    };

    "custom/cpu-icon" = {
      format = "󰻠";
      tooltip = false;
    };

    cpu = {
      format = "<b>{usage}󱉸</b>";
      "on-click" = "foot btop";
    };

    memory = {
      format = "<b>  \n{:2}󱉸</b>";
    };

    disk = {
      interval = 600;
      format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
      path = "/";
    };

    "custom/lock" = {
      tooltip = false;
      on-click = "${pkgs.bash}/bin/bash -c '(sleep 0.5s; ${lib.getExe pkgs.swaylock-effects} --grace 0)' & disown";
      format = "";
    };

    "tray" = {
      spacing = 10;
    };

    "custom/power" = {
      tooltip = false;
      on-click = let
        sudo = pkgs.sudo + "/bin/sudo";
        rofi = config.programs.rofi.package + "/bin/rofi";
        poweroff = pkgs.systemd + "/bin/poweroff";
        reboot = pkgs.systemd + "/bin/reboot";
      in
        pkgs.writeShellScript "shutdown-waybar" ''

          #!/bin/sh

          off=" Shutdown"
          reboot=" Reboot"
          cancel="󰅖 Cancel"

          sure="$(printf '%s\n%s\n%s' "$off" "$reboot" "$cancel" |
          	${rofi} -dmenu -p ' Are you sure?')"

          if [ "$sure" = "$off" ]; then
          	${sudo} ${poweroff}
          elif [ "$sure" = "$reboot" ]; then
          	${sudo} ${reboot}
          fi
        '';
      format = "󰐥";
    };
    clock = {
      format = ''
        {:%H
        %M}'';
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>
      '';
    };

    backlight = let
      brightnessctl = lib.getExe pkgs.brightnessctl;
    in {
      format = "{icon}";
      format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
      on-scroll-up = "${brightnessctl} s 5%-";
      on-scroll-down = "${brightnessctl} s +5%";
      tooltip = true;
      tooltip-format = "Brightness: {percent}% ";
      smooth-scrolling-threshold = 1;
    };

    battery = {
      rotate = 270;
      states = {
        good = 80;
        warning = 30;
        critical = 15;
      };
      format = "{icon}";
      format-charging = "<b>{icon} </b>";
      format-full = "<span color='#82A55F'><b>{icon}</b></span>";
      format-plugged = "󰂄";
      format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      tooltip-format = "{timeTo} {capacity} % | {power} W";
    };

    network = {
      format-wifi = "󰤨";
      format-ethernet = "󰈀";
      format-alt = "󱛇";
      format-disconnected = "󰤭";
    };

    "network#speed" = let
      nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    in {
      format = " {bandwidthDownBits} ";
      rotate = 90;
      interval = 5;
      tooltip-format = "{ipaddr}";
      tooltip-format-wifi = "{essid} ({signalStrength}%)   \n{ipaddr} | {frequency} MHz{icon} ";
      tooltip-format-ethernet = "{ifname} 󰈀 \n{ipaddr} | {frequency} MHz{icon} ";
      tooltip-format-disconnected = "Not Connected to any type of Network";
      tooltip = true;
      on-click = "${nm-editor}";
    };

    pulseaudio = {
      scroll-step = 5;
      tooltip = true;
      tooltip-format = "{volume}";
      on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
      format = "{icon}";
      format-muted = "󰝟";
      format-icons = {
        default = ["" "" ""];
      };
    };

    bluetooth = {
      # controller = "controller1", // specify the alias of the controller if there are more than 1 on the system
      format = "";
      format-disabled = "󰂲"; # an empty format will hide the module
      format-connected = "󰂱";
      tooltip-format = "{controller_alias}\t{controller_address}";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
      tooltip-format-disabled = "";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    };
  };
}
