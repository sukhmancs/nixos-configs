{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
  cfg = sys.services;

  inherit (cfg.vaultwarden.settings) port host;
in {
  config = {
    modules.system.services = {
      nginx.enable = true;
    };

    # this forces the system to create backup folder
    systemd.services.backup-vaultwarden.serviceConfig = {
      User = "root";
      Group = "root";
    };

    services = {
      vaultwarden = {
        enable = true;
        environmentFile = config.age.secrets.vaultwarden-env.path;
        backupDir = "/var/lib/vaultwarden/backup";
        config = {
          DOMAIN = "https://vault.xilain.dev";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = host;
          ROCKET_PORT = port;
          extendedLogging = true;
          invitationsAllowed = false;
          useSyslog = true;
          logLevel = "warn";
          showPasswordHint = false;
          signupsAllowed = false;
          signupsDomainsWhitelist = "xilain.dev";
          signupsVerify = false; #change back
          smtpAuthMechanism = "Login";
          smtpFrom = "vaultwarden@xilain.dev";
          smtpFromName = "XiLain's Vaultwarden Service";
          smtpHost = "mail.xilain.dev";
          smtpPort = 465;
          smtpSecurity = "force_tls";
          dataDir = "/var/lib/vaultwarden";
        };
      };

      nginx.virtualHosts."vault.xilain.dev" =
        {
          locations."/" = {
            proxyPass = "http://${host}:${toString port}";
            extraConfig = "proxy_pass_header Authorization;";
          };

          quic = true;
        }
        // lib.sslTemplate;

      fail2ban.jails = {
        vaultwarden-web = {
          filter = {
            INCLUDES.before = "common.conf";
            Definition = {
              failregex = "^.*Username or password is incorrect\. Try again\. IP: <ADDR>\. Username:.*$";
              ignoreregex = "";
            };
          };

          settings = {
            backend = "systemd";
            port = "80,443";
            filter = "vaultwarden-web[journalmatch='_SYSTEMD_UNIT=vaultwarden.service']";
            banaction = "%(banaction_allports)s";
            maxretry = 3;
            bantime = 14400;
            findtime = 14400;
          };
        };

        vaultwarden-admin = {
          filter = {
            INCLUDES.before = "common.conf";
            Definition = {
              failregex = "^.*Invalid admin token\. IP: <ADDR>.*$";
              ignoreregex = "";
            };
          };

          settings = {
            backend = "systemd";
            port = "80,443";
            filter = "vaultwarden-admin[journalmatch='_SYSTEMD_UNIT=vaultwarden.service']";
            banaction = "%(banaction_allports)s";
            maxretry = 3;
            bantime = 14400;
            findtime = 14400;
          };
        };
      };
    };
  };
}
