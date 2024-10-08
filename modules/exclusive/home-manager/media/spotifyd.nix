#
# spotifyd - A spotify daemon just like official spotify client but more lightweight.
#
# Current Issues:
# - Spotifyd will not work without Spotify Premium account. #TODO: Check if the issue is still present - https://github.com/Spotifyd/spotifyd
#
{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  credientals = {
    password_cmd = "${pkgs.coreutils}/bin/tail -1 /run/agenix/spotify";
    username_cmd = "${pkgs.coreutils}/bin/head -1 /run/agenix/spotify";
  };
in {
  config = mkIf config.services.spotifyd.enable {
    services = {
      spotifyd = {
        package = pkgs.spotifyd.override {withMpris = true;};
        settings.global = {
          inherit (credientals) password_cmd username_cmd;
          cache_path = "${config.xdg.cacheHome}/spotifyd";
          device_type = "computer";
          use_mpris = true;
          autoplay = true;

          # audio settings
          volume_normalisation = true;
          backend = "pulseaudio";
          bitrate = 320;
        };
      };
    };
  };
}
