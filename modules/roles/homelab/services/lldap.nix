{
  config,
  lib,
  ...
}: let
  inherit (config.age) secrets;

  inherit (lib) mkIf;

  sys = config.modules.system;
  cfg = sys.services;
  domain = "ldap.xilain.dev";

  inherit (cfg.ldap.settings) port host;
in {
  config = {
    modules.system.services = {
      nginx.enable = true;
    };

    services = {
      lldap = {
        enable = true;
        settings = {
          http_url = "https://${domain}";
          ldap_base_dn = "dc=xilain,dc=dev";
          # key_file = secrets.lldap_private_key.path;
        };
        environment = {
          LLDAP_JWT_SECRET_FILE = secrets.lldap_jwt_secret.path;
          LLDAP_LDAP_USER_PASS_FILE = secrets.lldap_user_pass.path;
          LLDAP_KEY_SEED_FILE = secrets.lldap_key_seed.path;
          LLDAP_LDAP_USER_DN = "admin";
          LLDAP_FORCE_LDAP_USER_PASS_RESET = "false";
        };
      };

      nginx.virtualHosts.${domain} =
        {
          locations."/" = {
            proxyPass = "http://${host}:${toString port}";
            proxyWebsockets = true;
          };

          quic = true;
        }
        // lib.sslTemplate;
    };

    systemd.services.lldap.serviceConfig.SupplementaryGroups = ["lldap-secrets"];
  };
}
