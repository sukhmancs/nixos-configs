{
  inputs',
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.mastodon.enable {
    services = {
      mastodon = {
        package = inputs'.nyxpkgs.packages.mastodon-bird-ui;

        user = "mastodon";

        configureNginx = false;
        trustedProxy = "127.0.0.1";
        localDomain = "social.xilain.dev";
        streamingProcesses = 2;

        webPort = 55001;
        sidekiqPort = 55002;
        enableUnixSocket = true;
        sidekiqThreads = 12;

        elasticsearch.host = "127.0.0.1";

        redis = {
          createLocally = false;
          host = "localhost";
          port = 6372;
        };

        database = {
          createLocally = true;
          host = "/run/postgresql";
          name = "mastodon";
          user = "mastodon";
        };

        # configure smtp
        smtp = {
          authenticate = true;
          createLocally = false;
          fromAddress = "noreply@xilain.dev";
          user = "noreply";
          host = "mail.xilain.dev";
          passwordFile = config.age.secrets.mailserver-noreply-secret.path;
        };

        # extra config
        extraConfig = {
          SINGLE_USER_MODE = "true";
          WEB_DOMAIN = "social.xilain.dev";
          AUTHORIZED_FETCH = "true";
        };
      };

      # this does what configureNginx option under the mastodon service is supposed to
      # to be able to fine-grain the service, we move it to its own configuration block
      # and also, I don't trust nixpkgs maintainers to properly maintain a service - so this is a safety net
      # in case they break another thing without proper documentation
      # /rant
      nginx = {
        virtualHosts."social.xilain.dev" =
          {
            root = "${config.services.mastodon.package}/public/";
            quic = true;

            locations = {
              "/" = {
                tryFiles = "$uri @proxy";
              };

              "/system/".alias = "/var/lib/mastodon/public-system/";

              "@proxy" = {
                proxyPass = "http://unix:/run/mastodon-web/web.socket";
                proxyWebsockets = true;
              };

              "/api/v1/streaming/" = {
                proxyPass = "http://unix:/run/mastodon-streaming/streaming.socket";
                proxyWebsockets = true;
              };
            };
          }
          // lib.sslTemplate;
      };
    };

    users.groups.mastodon.members = [config.services.nginx.user];
  };
}
