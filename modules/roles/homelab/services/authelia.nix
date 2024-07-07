#
# Authelia - Authentication and Authorization Server
#
# This server is setup to provide a single sign-on experience for all services
# that are behind it. It provides a 2FA experience for users. LLDAP is being used as
# the backend for user authentication.
#
# Pre-requisites:
# - LDAP server (LLDAP, etc) - This is used to store user information
# - Redis server - This is used to store session information
# - Postgres server - For the Authelia database
# - Nginx server - For reverse proxying
# - SMTP server - For sending emails
#
# Security:
# Brute Force Protection - max_retries, find_time, ban_time
# Unauthorized Access, Server Scanning - default_policy, networks, rules
# Account Takeover - password_reset
# Session Hijacking - refresh_interval
#
{
  config,
  pkgs,
  lib,
  ...
}: let
  authelia = config.services.authelia.instances.main;
  redis = config.services.redis.servers."";
  autheliaUrl = "http://${authelia.settings.server.host}:${builtins.toString authelia.settings.server.port}";
  inherit (lib) mkIf mkDefault;
  inherit (config.age) secrets;

  cfg = config.modules.system.services;

  inherit (cfg.authelia.settings) host port;
in {
  config = {
    networking.firewall.allowedTCPPorts = [port];

    environment.systemPackages = [
      pkgs.authelia
    ];

    users.users."${config.modules.system.mainUser}".extraGroups = ["authelia"];
    users.users."${authelia.user}".extraGroups = ["redis" "sendgrid"];

    services = {
      authelia.instances.main = {
        enable = true;
        secrets = {
          jwtSecretFile = config.age.secrets.authelia_jwt_secret.path;
          # oidcHmacSecretFile = "${pkgs.writeText "oidSecretFile" "supersecretkey"}";
          # oidcIssuerPrivateKeyFile = "${pkgs.writeText "oidcissuerSecretFile" "supersecretkey"}";
          sessionSecretFile = config.age.secrets.authelia_session_secret.path;
          storageEncryptionKeyFile = config.age.secrets.authelia_storage_encryption_key.path;
        };
        environmentVariables = {
          AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE = config.age.secrets.lldap_user_pass.path; # config.age.secrets.ldap_password.path;
          AUTHELIA_NOTIFIER_SMTP_PASSWORD_FILE = secrets.authelia_smtp_password.path;
          AUTHELIA_STORAGE_POSTGRES_PASSWORD_FILE = config.age.secrets.authelia_postgre_password.path;
        };
        #   settingsFiles = [config.age.secrets.authelia_secret_config.path];
        settings = {
          theme = "dark";
          default_redirection_url = "https://xilain.dev";
          default_2fa_method = "totp";
          server = {
            host = mkDefault host;
            port = mkDefault port;
          };
          log.level = "info";
          totp.issuer = "authelia.com";
          session = {
            domain = "xilain.dev";
            redis = {
              host = redis.unixSocket;
              port = 0;
              database_index = 0;
            };
          };
          regulation = {
            max_retries = 3;
            find_time = 120;
            ban_time = 300;
          };
          authentication_backend = {
            password_reset.disable = false;
            refresh_interval = "1m";
            ldap = {
              implementation = "custom";
              url = "ldap://localhost:3890";
              timeout = "5m";
              start_tls = false;
              base_dn = "dc=xilain,dc=dev";
              username_attribute = "uid";
              additional_users_dn = "ou=people";
              users_filter = "(&({username_attribute}={input})(objectClass=person))";
              additional_groups_dn = "ou=groups";
              groups_filter = "(member={dn})";
              group_name_attribute = "cn";
              mail_attribute = "mail";
              display_name_attribute = "displayName";
              user = "uid=admin,ou=people,dc=xilain,dc=dev";
            };
          };
          access_control = {
            default_policy = "deny";
            networks = [
              {
                name = "localhost";
                networks = ["127.0.0.1/32"];
              }
              {
                name = "internal";
                networks = [
                  "10.100.0.0/8"
                  "172.16.0.0/12"
                  "192.168.0.0/16"
                  "102.209.85.226/27"
                  "174.119.200.86" # My home public IP
                ];
              }
            ];
            rules = [
              {
                domain = ["manga.xilain.dev"];
                policy = "one_factor";
                subject = [
                  "group:lldap_strict_readonly"
                ];
              }
              {
                domain = ["*.xilain.dev"];
                policy = "bypass";
                networks = "localhost";
              }
              {
                domain = ["*.xilain.dev"];
                policy = "one_factor";
                networks = "internal";
                subject = [
                  "group:lldap_strict_readonly"
                ];
              }
            ];
          };
          storage = {
            postgres = {
              host = "/run/postgresql";
              database = "authelia-main";
              port = 5432;
              username = authelia.user;
            };
          };
          notifier = {
            disable_startup_check = false;
            smtp = {
              host = "mail.xilain.dev";
              port = 465;
              username = "authelia@xilain.dev";
              sender = "Authelia <authelia@xilain.dev>";
            };
          };
        };
      };

      nginx.virtualHosts."auth.xilain.dev" =
        {
          forceSSL = true;
          extraConfig = ''
              location / {
                set $upstream_authelia http://${host}:${toString port};
                proxy_pass $upstream_authelia;
                client_body_buffer_size 128k;

                #Timeout if the real server is dead
                proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;

                # Advanced Proxy Config
                send_timeout 5m;
                proxy_read_timeout 360;
                proxy_send_timeout 360;
                proxy_connect_timeout 360;

                # Basic Proxy Config
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Host $http_host;
                proxy_set_header X-Forwarded-Uri $request_uri;
                proxy_set_header X-Forwarded-Ssl on;
                proxy_redirect  http://  $scheme://;
                proxy_http_version 1.1;
                proxy_set_header Connection "";
                proxy_cache_bypass $cookie_session;
                proxy_no_cache $cookie_session;
                proxy_buffers 64 256k;

                # If behind reverse proxy, forwards the correct IP
                set_real_ip_from 10.0.0.0/8;
                set_real_ip_from 172.0.0.0/8;
                set_real_ip_from 192.168.0.0/16;
                set_real_ip_from fc00::/7;
                real_ip_header X-Forwarded-For;
                real_ip_recursive on;
            }
          '';
        }
        // lib.sslTemplate;
    };

    systemd.services.authelia.after = ["lldap.service"];
  };
}
