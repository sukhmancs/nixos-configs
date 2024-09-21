{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) modules;

  dev = osConfig.modules.device.type;

  # swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  swaylock = getExe config.programs.swaylock.package;
  pgrep = "${pkgs.procps}/bin/pgrep";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";

  isLocked = "${pgrep} -x ${swaylock}";
  lockTime =
    if dev == "laptop"
    then 4 * 60
    else 10 * 60; # 4 minutes for laptops, 10 minutes for desktops

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = {
    timeout,
    command,
    resumeCommand ? null,
  }: [
    {
      timeout = lockTime + timeout;
      inherit command resumeCommand;
    }
    {
      command = "${isLocked} && ${command}";
      inherit resumeCommand timeout;
    }
  ];

  # only lock if no audio is playing
  # lock = pkgs.writeShellScript "lock" ''
  #   ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
  #   if [ $? == 1 ]; then
  #     ${swaylock} --image ${modules.themes.wallpaper}
  #   fi
  # '';

  # This script uses pw-cli and ripgrep to check if any audio streams are running.
  # If audio is running, the script will return a status code of 0 (true).
  # If no audio is running, it will return a status code of 1 (false).
  isAudioRunning = pkgs.writeShellScript "is-audio-running" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
  '';
in {
  config = mkIf config.services.swayidle.enable {
    services.swayidle = {
      systemdTarget = "graphical-session.target";
      timeouts =
        # Lock screen
        [
          {
            timeout = lockTime;
            # command = "${swaylock} --image ${modules.themes.wallpaper} --daemonize --grace 15";
            # command = "${lock}";
            command = "${isAudioRunning} || ${swaylock} --image ${modules.themes.wallpaper}";
          }
        ]
        ++
        # Turn off displays (hyprland)
        (lib.optionals config.wayland.windowManager.hyprland.enable (afterLockTimeout {
          timeout = 5;
          command = "${isAudioRunning} || ${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }))
        ++
        # Turn off displays (sway)
        (lib.optionals config.wayland.windowManager.sway.enable (afterLockTimeout {
          timeout = 40;
          command = "${isAudioRunning} || ${swaymsg} 'output * dpms off'";
          resumeCommand = "${swaymsg} 'output * dpms on'";
        }));
    };
  };
}
