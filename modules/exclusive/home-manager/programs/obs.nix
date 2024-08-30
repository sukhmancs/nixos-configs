{ config, pkgs, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.obs-studio.enable {
    programs = {
      # live streaming
      obs-studio = {
        plugins = with pkgs.obs-studio-plugins;
          [
            # screen capture
            wlrobs
            # obs-ndi
            obs-vaapi
            obs-nvfbc
            obs-teleport
            # obs-hyperion
            droidcam-obs
            obs-vkcapture
            obs-gstreamer
            obs-3d-effect
            input-overlay
            obs-multi-rtmp
            obs-source-clone
            obs-shaderfilter
            obs-source-record
            obs-livesplit-one
            looking-glass-obs
            obs-vintage-filter
            obs-command-source
            obs-move-transition
            obs-backgroundremoval
            advanced-scene-switcher
            obs-pipewire-audio-capture
          ];
      };
    };
  };
}
