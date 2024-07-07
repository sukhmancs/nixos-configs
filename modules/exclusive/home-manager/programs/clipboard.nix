{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf mkGraphicalService getExe;
  inherit (osConfig) modules;

  prg = modules.home.programs.clipboard;
in {
  config = mkIf prg.enable {
    systemd.user.services = {
      cliphist = mkGraphicalService {
        Unit.Description = "Clipboard history service";
        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${getExe pkgs.cliphist} store";
          Restart = "always";
        };
      };

      wl-clip-persist = mkGraphicalService {
        Unit.Description = "Persistent clipboard for Wayland";
        Service = {
          ExecStart = "${getExe pkgs.wl-clip-persist} --clipboard both";
          Restart = "always";
        };
      };
    };
  };
}
