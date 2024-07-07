{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
  cfg = sys.services;
in {
  config = {
    services.redis = {
      vmOverCommit = true;
      servers = {
        nextcloud = mkIf cfg.nextcloud.enable {
          enable = true;
          user = "nextcloud";
          port = 0;
        };

        searxng = mkIf cfg.searxng.enable {
          enable = true;
          user = "searx";
          port = 6370;
          databases = 16;
          logLevel = "debug";
          requirePass = "searxng";
        };

        forgejo = mkIf cfg.forgejo.enable {
          enable = true;
          user = "forgejo";
          port = 6371;
          databases = 16;
          logLevel = "debug";
          requirePass = "forgejo";
        };

        mastodon = mkIf cfg.social.mastodon.enable {
          enable = true;
          user = "mastodon";
          port = 6372;
          databases = 16;
          logLevel = "debug";
        };

        "" = mkIf cfg.authelia.enable {
          enable = true;
          # user = "authelia";
          port = 0;
          databases = 16;
          logLevel = "debug";
        };
      };
    };
  };
}
