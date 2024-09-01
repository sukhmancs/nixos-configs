#
# WayPipe - Remotely run graphical applications under a Wayland compositor
#
# Usage:
#   Run a graphical program remotely and display it locally:
#      `waypipe ssh user@server program`
#
#   Open an SSH tunnel to run any program remotely and display it locally:
#      `waypipe ssh user@server`
#
{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.home.programs.waypipe;
in {
  config = mkIf prg.enable {
    home.packages = [pkgs.waypipe];
    systemd.user.services = {
      waypipe-client = {
        Unit.Description = "Runs waypipe on startup to support SSH forwarding";
        Service = {
          ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} %h/.waypipe -p";
          ExecStart = "${lib.getExe pkgs.waypipe} --socket %h/.waypipe/client.sock client";
          ExecStopPost = "${lib.getExe' pkgs.coreutils "rm"} -f %h/.waypipe/client.sock";
        };
        Install.WantedBy = ["graphical-session.target"];
      };
      waypipe-server = {
        Unit.Description = "Runs waypipe on startup to support SSH forwarding";
        Service = {
          Type = "simple";
          ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} %h/.waypipe -p";
          ExecStart = "${lib.getExe pkgs.waypipe} --socket %h/.waypipe/server.sock --title-prefix '[%H] ' --login-shell --display wayland-waypipe server -- ${lib.getExe' pkgs.coreutils "sleep"} infinity";
          ExecStopPost = "${lib.getExe' pkgs.coreutils "rm"} -f %h/.waypipe/server.sock %t/wayland-waypipe";
        };
        Install.WantedBy = ["default.target"];
      };
    };
  };
}
