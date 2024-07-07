{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) optionalString primaryMonitor;
  sys = osConfig.modules.system;
in {
  mainBar = {
    layer = "top";
    position = "right";
    # monitor configuration, kind of dirty since it assumes DP-1 is my main monitor
    output = primaryMonitor osConfig; #builtins.elemAt monitors 0;
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
      "custom/weather"
      "custom/todo"
      "group/info"
    ];
    modules-center = ["hyprland/workspaces"];
    modules-right = [
      "group/info-right"
      "battery"
      "group/network"
      "group/cnoti"
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

    "hyprland/submap" = {
      format = "<b>󰇘</b>";
      "max-length" = 8;
      tooltip = true;
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
        "custom/swallow"
        (optionalString sys.bluetooth.enable "bluetooth")
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

    "group/cnoti" = {
      orientation = "inherit";
      modules = [
        "custom/github"
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

    "keyboard-state" = {
      numlock = true;
      capslock = true;
      format = "{name} {icon}";
      format-icons = {
        locked = "";
        unlocked = "";
      };
      tooltip = true;
    };

    memory = {
      format = "<b>  \n{:2}󱉸</b>";
    };

    disk = {
      interval = 600;
      format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
      path = "/";
    };

    privacy = {
      orientation = "vertical";
      icon-spacing = 4;
      icon-size = 14;
      "transition-duration" = 250;
      modules = [
        {
          type = "screenshare";
          tooltip = true;
          "tooltip-icon-size" = 24;
        }
      ];
    };

    "custom/screenshare" = {
      format = "󰇘";
      tooltip = true;
      tooltip-format = "Screen sharing is active";
    };

    "custom/todo" = {
      format = "🗒️";
      tooltip = true;
      interval = 7;
      exec = let
        todo = pkgs.todo + "/bin/todo";
        sed = pkgs.gnused + "/bin/sed";
        wc = pkgs.coreutils + "/bin/wc";
      in
        pkgs.writeShellScript "todo-waybar" ''
          #!/bin/sh

          total_todo=$(${todo} | ${wc} -l)
          todo_raw_done=$(${todo} raw done | ${sed} 's/^/      ◉ /' | ${sed} -z 's/\n/\\n/g')
          todo_raw_undone=$(${todo} raw todo | ${sed} 's/^/     ◉ /' | ${sed} -z 's/\n/\\n/g')
          done=$(${todo} raw done | ${wc} -l)
          undone=$(${todo} raw todo | ${wc} -l)
          tooltip=$(${todo})

          left="$done/$total_todo"

          header="<b>todo</b>\\n\\n"
          tooltip=""
          if [[ $total_todo -gt 0 ]]; then
          	if [[ $undone -gt 0 ]]; then
          		export tooltip="$header👷 Today, you need to do:\\n\\n $(echo $todo_raw_undone)\\n\\n✅ You have already done:\\n\\n $(echo $todo_raw_done)"
          		export output=" 🗒️ \\n $left"
          	else
          		export tooltip="$header✅ All done!\\n🥤 Remember to stay hydrated!"
          		export output=" 🎉 \\n $left"
          	fi
          else
          	export tooltip=""
          	export output=""
          fi

          printf '{"text": "%s", "tooltip": "%s" }' "$output" "$tooltip"
        '';
      return-type = "json";
    };

    "custom/weather" = let
      waybar-wttr = pkgs.stdenv.mkDerivation {
        name = "waybar-wttr";
        buildInputs = [(pkgs.python3.withPackages (pythonPackages: with pythonPackages; [requests]))];
        unpackPhase = "true";
        installPhase = ''
          mkdir -p $out/bin
          cp ${../../scripts/waybar-wttr.py} $out/bin/waybar-wttr
          chmod +x $out/bin/waybar-wttr
        '';
      };
    in {
      format = "{}";
      tooltip = true;
      interval = 30;
      exec = "${waybar-wttr}/bin/waybar-wttr";
      return-type = "json";
    };

    "custom/lock" = {
      tooltip = false;
      on-click = "${pkgs.bash}/bin/bash -c '(sleep 0.5s; ${lib.getExe pkgs.swaylock-effects} --grace 0)' & disown";
      format = "";
    };

    "tray" = {
      spacing = 10;
    };

    "custom/swallow" = {
      tooltip = false;
      on-click = let
        hyprctl = config.wayland.windowManager.hyprland.package + "/bin/hyprctl";
        notify-send = pkgs.libnotify + "/bin/notify-send";
        rg = pkgs.ripgrep + "/bin/rg";
      in
        pkgs.writeShellScript "waybar-swallow" ''
          #!/bin/sh
          if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
          	${hyprctl} keyword misc:enable_swallow false >/dev/null &&
          	${notify-send} "Hyprland" "Turned off swallowing"
          else
          	${hyprctl} keyword misc:enable_swallow true >/dev/null &&
          	${notify-send} "Hyprland" "Turned on swallowing"
          fi
        '';
      format = "󰊰";
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

    gamemode = {
      format = "󰊴";
      format-alt = "{glyph}";
      glyph = "󰊴";
      hide-not-running = true;
      use-icon = true;
      icon-name = "input-gaming-symbolic";
      icon-spacing = 4;
      icon-size = 20;
      tooltip = true;
      tooltip-format = "Games running: {count}";
    };

    "custom/github" = {
      format = "{}";
      return-type = "json";
      interval = 3600;
      signal = 9;
      on-click = "xdg-open https://github.com/notifications;pkill -RTMIN+9 waybar";
      exec = let
        token = ''
          tail ${osConfig.age.secrets.github_notification_token.path} -n 1
        '';
      in
        pkgs.writeShellScript "github-waybar" ''
          #!/bin/sh

          check() {
            command -v &>/dev/null
          }

          count="0"
          count=$(curl -su sukhmancs:${token} https://api.github.com/notifications | jq '. | length')
          if [ -z "$count" ]; then
            count="0"
          fi

          if [ "$count" -gt 0 ]; then
            cat <<EOF
          {"text":"\n$count","tooltip":"<b>Github: $count Notifications</b>"}
          EOF
          else
            cat <<EOF
          {"text":"","tooltip":"<b>Github: $count Notifications</b>"}
          EOF
          fi
        '';
    };
  };
}
