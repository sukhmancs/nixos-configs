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
      "group/info"
    ];
    modules-center = ["river/tags"];
    modules-right = [
      "group/info-right"
      "battery"
      "group/network"
      "clock"
      # "custom/lock"
    ];

    ##### LEFT MODULES #####
    "custom/search" = {
      format = " ";
      tooltip = false;
      on-click = "${lib.getExe pkgs.killall} rofi || run-as-service $(rofi -show drun)";
    };

    #### INFO MODULE - START ####
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

    "custom/dmark" = {
      format = "";
      tooltip = false;
    };

    #### CPU MODULE - START ####
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
    ##### CPU MODULE - END #####

    memory = {
      format = "<b>  \n{:2}󱉸</b>";
    };

    disk = {
      interval = 600;
      format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
      path = "/";
    };
    #### INFO MODULE - END ####

    ##### CENTER MODULES #####
    "river/tags" = {
      num-tags = 5;
      tag-labels = ["一" "二" "三" "四" "五" "六" "七" "八" "九" "十"];
    };

    ##### RIGHT MODULES #####
    ##### RIGHT INFO MODULE - START ####
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

    "custom/dmark-up" = {
      format = "";
      tooltip = false;
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

    "tray" = {
      spacing = 10;
    };

    ##### RIGHT INFO MODULE - END ####

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

    #### NETWORK MODULE - START ####
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

    #### NETWORK MODULE - END ####

    clock = {
      format = ''
        {:%H
        %M}'';
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>
      '';
    };

    "custom/lock" = {
      tooltip = false;
      on-click = "${pkgs.bash}/bin/bash -c '(sleep 0.5s; ${lib.getExe pkgs.swaylock-effects} --grace 0)' & disown";
      format = "";
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
  };
}
