{
  config,
  lib,
  ...
}: let
  inherit (config.age) secrets;

  sys = config.modules.system;
  cfg = sys.services;
  domain = "ldap.xilain.dev";

  inherit (cfg.ldap.settings) port host;
in {
  config = {
    services = {
      lldap = {
        enable = false;
        settings = {
          http_url = "https://${domain}"; # the url of the ldap server
          ldap_base_dn = "dc=xilain,dc=dev"; # the root of the ldap directory tree
          # key_file = secrets.lldap_private_key.path;
        };
        environment = {
          LLDAP_JWT_SECRET_FILE = secrets.lldap_jwt_secret.path;
          # LLDAP_LDAP_USER_PASS_FILE = secrets.lldap_user_pass.path; # password for the admin user
          # LLDAP_KEY_SEED_FILE = secrets.lldap_key_seed.path;
          # LLDAP_LDAP_USER_DN = "admin"; # ldap username
          # LLDAP_FORCE_LDAP_USER_PASS_RESET = "false";
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
