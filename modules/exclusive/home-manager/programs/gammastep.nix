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
      tray = false;
      enableVerboseLogging = true;
      temperature = {
        day = 5700;
        night = 4000;
      };
      settings = {
        general = {
          fade = "1";
          brightness-day = "1.0";
          brightness-night = "0.8";
          location-provider = "manual";
          adjustment-method = "wayland";

          # Custom dawn/dusk intervals.
          # Instead of using the solar elevation, the time intervals of dawn and dusk
          # can be specified manually. The times must be specified as HH:MM in 24-hour
          # format.
          #dawn-time = "6:00-7:45";
          #dusk-time = "18:35-20:15";
        };
        manual = {
          # On, Canada
          lat = "50.0"; # latitude
          lon = "-85.0"; # longitude
        };
      };
    };
  };
}
