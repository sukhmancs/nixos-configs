#
# GammaStep - A tool to adjust the color temperature of your screen
#
{
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.gammastep.enable {
    services.gammastep = {
      provider = "geoclue2";
    };
  };
}
