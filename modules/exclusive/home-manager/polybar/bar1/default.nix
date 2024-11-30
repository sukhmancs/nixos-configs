{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  config = mkIf config.services.polybar.enable {
    services.polybar = {
      config = "./config/config.ini";
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };
    };
  };
}
