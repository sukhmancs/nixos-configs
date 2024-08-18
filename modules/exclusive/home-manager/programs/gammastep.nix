#
# GammaStep - A tool to adjust the color temperature of your screen
#
{ lib
, config
, ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.services.gammastep.enable {
    services.gammastep = {
      provider = "geoclue2";
      enableVerboseLogging = true;
      temperature = {
        day = 6000;
        night = 4600;
      };
      settings = {
        general.adjustment-method = "wayland";
      };
    };
  };
}
