{
  inputs',
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) readFile;
  inherit (lib.modules) mkForce;
  inherit (lib.strings) makeBinPath;

  dependencies = with pkgs;
    [
      coreutils
      power-profiles-daemon
      inotify-tools
      libnotify
      jaq
    ]
    ++ [
      inputs'.hyprland.packages.hyprland
    ];
in {
  config = {
    # Power state monitor. Switches Power profiles based on charging state.
    # Plugged in - balanced
    # Unplugged - power-saver
    systemd.user.services."power-monitor" = {
      description = "Power Monitoring Service";
      environment.PATH = mkForce "/run/wrappers/bin:${makeBinPath dependencies}";
      script = readFile ./scripts/power_monitor.sh;

      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
      };

      wants = ["power-profiles-daemon.service"];
      wantedBy = ["default.target"];
    };
  };
}
