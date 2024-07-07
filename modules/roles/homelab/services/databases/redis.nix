{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = {
    services.redis = {
      vmOverCommit = true;
      servers = {
        nextcloud = mkIf config.services.nextcloud.enable {
          enable = true;
          user = "nextcloud";
          port = 0;
        };

        searxng = mkIf config.services.searx.enable {
          enable = true;
          user = "searx";
          port = 6370;
          databases = 16;
          logLevel = "debug";
          requirePass = "searxng";
        };

        forgejo = mkIf config.services.forgejo.enable {
          enable = true;
          user = "forgejo";
          port = 6371;
          databases = 16;
          logLevel = "debug";
          requirePass = "forgejo";
        };

        mastodon = mkIf config.services.mastodon.enable {
          enable = true;
          user = "mastodon";
          port = 6372;
          databases = 16;
          logLevel = "debug";
        };

        "" = mkIf ((config ? services.authelia.instances.main) && config.services.authelia.instances.main.enable) {
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
