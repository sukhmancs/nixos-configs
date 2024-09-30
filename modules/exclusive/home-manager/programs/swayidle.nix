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

  swaylock = getExe config.programs.swaylock.package;
  pgrep = "${pkgs.procps}/bin/pgrep";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

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
    # {
    #   command = "${isLocked} && ${command}";
    #   inherit resumeCommand timeout;
    # }
  ];

  isNoAudioRunning = pkgs.writeShellScript "is-no-audio-running" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      exit 0
    else
      exit 1
    fi
  '';
in {
  config = mkIf config.services.swayidle.enable {
    services.swayidle = {
      systemdTarget = "graphical-session.target";
      timeouts =
        # Rather than relying on some weird scripts to dim the screen,
        # We can just use brightnessctl to do it for us.
        # Dim screen before locking
        [
          {
            timeout = lockTime - 10; # Dim the screen 10 seconds before locking
            command = "${brightnessctl} set 10%";
            resumeCommand = "${brightnessctl} set 100%"; # Restore brightness on resume
          }
        ]
        ++
        # Lock screen
        [
          {
            timeout = lockTime;
            command = "${isNoAudioRunning} && ${brightnessctl} set 100% && ${swaylock} --image ${modules.themes.wallpaper}";
          }
        ]
        ++
        # Turn off displays (hyprland)
        (lib.optionals config.wayland.windowManager.hyprland.enable (afterLockTimeout {
          timeout = 5;
          command = "${isNoAudioRunning} && ${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }))
        ++
        # Turn off displays (sway)
        (lib.optionals config.wayland.windowManager.sway.enable (afterLockTimeout {
          timeout = 40;
          command = "${isNoAudioRunning} && ${swaymsg} 'output * dpms off'";
          resumeCommand = "${swaymsg} 'output * dpms on'";
        }));
    };
  };
}
