{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules meta;
in {
  config = mkIf config.programs.obs-studio.enable {
    programs.obs-studio = {
      plugins = with pkgs.obs-studio-plugins;
        [
          obs-gstreamer
          obs-pipewire-audio-capture
          obs-vkcapture
        ]
        ++ optional meta.isWayland
        pkgs.obs-studio-plugins.wlrobs;
    };
  };
}
