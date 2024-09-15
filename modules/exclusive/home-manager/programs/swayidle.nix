{ pkgs
, lib
, config
, osConfig
, ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  dev = osConfig.modules.device.type;

  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
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
  afterLockTimeout =
    { timeout
    , command
    , resumeCommand ? null
    ,
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
in
{
  config = mkIf config.services.swayidle.enable {
    services.swayidle = {
      systemdTarget = "graphical-session.target";
      timeouts =
        # Lock screen
        [
          {
            timeout = lockTime;
            command = "${swaylock} --daemonize --grace 15";
          }
        ]
        ++
        # Turn off displays (hyprland)
        (lib.optionals config.wayland.windowManager.hyprland.enable (afterLockTimeout {
          timeout = 5;
          command = "${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }))
        ++
        # Turn off displays (sway)
        (lib.optionals config.wayland.windowManager.sway.enable (afterLockTimeout {
          timeout = 40;
          command = "${swaymsg} 'output * dpms off'";
          resumeCommand = "${swaymsg} 'output * dpms on'";
        }));
    };
  };
}
