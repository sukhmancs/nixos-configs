{lib, ...}: let
  inherit (lib) mkService mkOption types;
in {
  options.modules.system.services = {
    homelab = {
      homepage = mkService {
        name = "Homepage";
        type = "Dashboard";
        port = 8082;
        host = "127.0.0.1";
        extraOptions = {
          settings = mkOption {
            type = types.attrs;
            default = {};
          };
          services = mkOption {
            type = types.listOf types.attrs;
            default = [];
          };
          widgets = mkOption {
            type = types.listOf types.attrs;
            default = [];
          };
          bookmarks = mkOption {
            type = types.listOf types.attrs;
            default = [];
          };
        };
      };
    };
  };
}
