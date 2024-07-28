#
#  Bspwm Configuration
#  Enable with "bspwm.enable = true;"
#
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
# with host;
  let
    #   monitor =
    #     if hostName == "beelink" then
    #       "${pkgs.xorg.xrandr}/bin/xrandr --output ${secondMonitor} --mode 1920x1080 --pos 0x0 --rotate normal --output ${mainMonitor} --primary --mode 1920x1080 --pos 1920x0 --rotate normal"
    #     else if hostName == "work" then
    #       "${pkgs.xorg.xrandr}/bin/xrandr --output ${mainMonitor} --mode 1920x1080 --pos 0x0 --rotate normal --primary --output ${secondMonitor} --mode 1920x1200 --pos 1920x0 --rotate normal --output ${thirdMonitor} --mode 1920x1200 --pos 3840x0 --rotate normal"
    #     else if hostName == "vm" || hostName == "probook" then
    #       "${pkgs.xorg.xrandr}/bin/xrandr --mode 1920x1080 --pos 0x0 --rotate normal"
    #     else "";
    # extra = ''
    #   killall -q polybar &
    #   while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done
    #   WORKSPACES
    #   bspc config border_width      3
    #   bspc config window_gaps      12
    #   bspc config split_ratio     0.5
    #   bspc config click_to_focus            true
    #   bspc config focus_follows_pointer     false
    #   bspc config borderless_monocle        false
    #   bspc config gapless_monocle           false
    #   #bspc config normal_border_color  "#000000"
    #   #bspc config focused_border_color "#ffffff"
    #   #pgrep -x sxhkd > /dev/null || sxhkd &
    #   feh --bg-tile $HOME/.config/wall.png
    #   polybar main & #2>~/log &
    # '';
    # extraConf =
    #   builtins.replaceStrings ["WORKSPACES"]
    #   [
    #     (
    #       if hostName == "beelink" || hostName == "work"
    #       then ''
    #         bspc monitor ${mainMonitor} -d 1 2 3
    #         bspc monitor ${secondMonitor} -d 4 5 6
    #         bspc monitor ${thirdMonitor} -d 7 8 9
    #         bspc wm -O ${mainMonitor} ${secondMonitor} ${thirdMonitor}
    #         polybar sec &
    #         polybar thi &
    #       ''
    #       else if hostName == "vm" || hostName == "probook"
    #       then ''
    #         bspc monitor -d 1 2 3 4 5
    #       ''
    #       else ""
    #     )
    #   ]
    #   "${extra}";
  in {
    # options = {
    #   bspwm = {
    #     enable = mkOption {
    #       type = types.bool;
    #       default = false;
    #     };
    #   };
    # };

    config =
      #   mkIf (config.bspwm.enable)
      {
        services = {
          displayManager.defaultSession = "none+bspwm";
          #   libinput = {
          #     enable = true;
          #     touchpad = {
          #       tapping = true;
          #       scrollMethod = "twofinger";
          #       naturalScrolling = true;
          #       accelProfile = "adaptive";
          #       disableWhileTyping = true;
          #     };
          #   };
          xserver = {
            enable = true;
            xkb = {
              layout = "us";
              options = "eurosign:e";
            };
            autoRepeatInterval = 50;
            autoRepeatDelay = 200;
            # modules = [pkgs.xf86_input_wacom];
            # wacom.enable = true;

            displayManager = {
              lightdm = {
                enable = true;
                # background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
                # greeters = {
                #   gtk = {
                #     theme = {
                #       name = "Dracula";
                #       package = pkgs.dracula-theme;
                #     };
                #     cursorTheme = {
                #       name = "Dracula-cursors";
                #       package = pkgs.dracula-theme;
                #       size = 16;
                #     };
                #   };
                # };
              };
            };
            windowManager.bspwm = {
              enable = true;
            };

            # displayManager.sessionCommands = monitor;

            serverFlagsSection = ''
              Option "BlankTime" "0"
              Option "StandbyTime" "0"
              Option "SuspendTime" "0"
              Option "OffTime" "0"
            ''; # Disable Sleep

            resolutions = [
              {
                x = 1920;
                y = 1080;
              }
              {
                x = 1920;
                y = 1200;
              }
              {
                x = 1600;
                y = 900;
              }
              {
                x = 3840;
                y = 2160;
              }
            ];
          };
        };

        # programs.zsh.enable = true;

        environment.systemPackages = with pkgs; [
          xclip # Clipboard
          xorg.xev # Event Viewer
          xorg.xkill # Process Killer
          xorg.xrandr # Monitor Settings
          xterm # Terminal
        ];
      };
  }
