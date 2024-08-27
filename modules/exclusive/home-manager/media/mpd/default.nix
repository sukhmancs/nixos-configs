{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf config.services.mpd.enable {
    home.packages = with pkgs; [
      mpc-cli # CLI interface for mpd
      playerctl # CLI interface for playerctld
    ];

    services = {
      playerctld.enable = true;
      mpris-proxy.enable = true;
      mpd-mpris.enable = true;

      # music player daemon service
      mpd = {
        dbFile = "${config.xdg.configHome}/mpd/database";
        dataDir = "${config.xdg.configHome}/mpd";
        musicDirectory = "${config.xdg.userDirs.music}";
        network = {
          startWhenNeeded = true;
          listenAddress = "127.0.0.1";
          port = 6600;
        };

        extraConfig = ''
          auto_update           "yes"
          volume_normalization  "yes"
          restore_paused        "yes"
          filesystem_charset    "UTF-8"

          audio_output {
            type                "pipewire"
            name                "PipeWire"
          }

          audio_output {
            type                "fifo"
            name                "Visualiser"
            path                "/tmp/mpd.fifo"
            format              "44100:16:2"
          }

          audio_output {
           type		              "httpd"
           name		              "lossless"
           encoder		          "flac"
           port		              "8000"
           max_clients	        "8"
           mixer_type	          "software"
           format		            "44100:16:2"
          }
        '';
      };

      # MPRIS 2 support to mpd
      mpdris2 = {
        enable = true;
        notifications = true;
        multimediaKeys = true;
        mpd = {
          inherit (config.services.mpd) musicDirectory;
        };
      };

      # discord rich presence for mpd
      mpd-discord-rpc = {
        enable = true;
        settings = {
          format = {
            details = "$title";
            state = "On $album by $artist";
            large_text = "$album";
            small_image = "";
          };
        };
      };
    };
  };
}
