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
  config = {
    services.polybar = {
      enable = true;
      config = "./config/config.ini";
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };
      script = "polybar karla-bar &";
    };
  };
}
