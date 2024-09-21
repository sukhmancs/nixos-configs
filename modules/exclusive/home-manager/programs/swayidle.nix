{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
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
  lock = pkgs.writeShellScript "lock" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      ${swaylock} --image ${modules.themes.wallpaper} --daemonize --grace 15
    fi
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
            command = "${lock}";
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
