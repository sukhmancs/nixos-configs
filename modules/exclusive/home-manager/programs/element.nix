{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.home;
  prg = sys.programs;
in {
  config = mkIf prg.element.enable {
    home.packages = [pkgs.element-desktop];

    xdg.configFile = {
      "Element/config.json".text = builtins.toJSON {
        default_server_config = {
          "m.homeserver" = {
            base_url = "https://xilain.dev";
            server_name = "xilain.dev";
          };

          "m.identity_server" = {base_url = "";};
        };

        show_labs_settings = true;
        default_theme = "dark";
      };
    };
  };
}
