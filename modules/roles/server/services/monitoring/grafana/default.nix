{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  # imports = [./dashboards.nix];
  config = {
    networking.firewall.allowedTCPPorts = [config.services.grafana.settings.server.http_port];

    services = {
      grafana = {
        enable = true;
        settings = {
          server = {
            http_addr = "0.0.0.0";
            http_port = 3000;

            root_url = "https://dash.xilain.dev";
            domain = "dash.xilain.dev";
            enforce_domain = true;
          };

          database = {
            type = "postgres";
            host = "/run/postgresql";
            name = "grafana";
            user = "grafana";
            ssl_mode = "disable";
          };

          security = {
            cookie_secure = true;
            disable_gravatar = true;
          };

          analytics = {
            reporting_enabled = false;
            check_for_updates = false;
          };

          "auth.anonymous".enabled = false;
          "auth.basic".enabled = false;

          users = {
            allow_signup = false;
          };
        };

        provision = {
          enable = true;
          datasources.settings = {
            datasources = [
              (mkIf config.services.prometheus.enable {
                name = "Prometheus";
                type = "prometheus";
                access = "proxy";
                orgId = 1;
                uid = "Y4SSG429DWCGDQ3R";
                url = "http://127.0.0.1:${toString config.services.prometheus.port}";
                isDefault = true;
                version = 1;
                editable = true;
                jsonData = {
                  graphiteVersion = "1.1";
                  tlsAuth = false;
                  tlsAuthWithCACert = false;
                };
              })

              (mkIf config.services.loki.enable {
                name = "Loki";
                type = "loki";
                access = "proxy";
                url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}";
              })

              (mkIf config.services.postgresql.enable {
                name = "PostgreSQL";
                type = "postgres";
                access = "proxy";
                url = "http://127.0.0.1:9103";
              })
            ];

            # typos go here
            deleteDatasources = [
              {
                name = "postgres";
                orgId = 0;
              }
              {
                name = "redis";
                orgId = 0;
              }
              {
                name = "Endlessh-go";
                orgId = 0;
              }
            ];
          };
        };
      };

      nginx.virtualHosts."dash.xilain.dev" =
        {
          locations."/" = {
            proxyPass = with config.services.grafana.settings.server; "http://${toString http_addr}:${toString http_port}/";
            proxyWebsockets = true;
          };

          quic = true;
        }
        // {
          addSSL = true;
          enableACME = true;
        };
    };
  };
}
