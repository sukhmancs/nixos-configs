#
# Seatd - Seat management daemon
#
# Seat management daemon is a daemon that manages access to input and output
# (keyboard, mouse, display, etc.) devices based on what group a user is in.
# Configuration defined here is not a multi-seat setup. If the user is in the wheel group,
# they have access to input and output devices.
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe;
in {
  config = mkIf config.services.seatd.enable {
    systemd.services = {
      seatd = {
        description = "Seat management daemon";
        # The -g wheel option in this script configures seatd to use the
        # wheel group. You should ensure that users who need access to
        # input and output devices are members of the wheel group.
        script = "${getExe pkgs.seatd} -g wheel";
        serviceConfig = {
          Type = lib.mkForce "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
