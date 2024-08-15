{lib, ...}: let
  inherit (lib) mkService mkOption types;
  inherit (lib.options) mkEnableOption;
in {
  imports = [
    ./bincache.nix
    ./databases.nix
    ./monitoring.nix
    ./networking.nix
    ./social.nix
    ./homelab.nix
    ./authelia.nix
  ];

  options.modules.system = {
    services = {
      mailserver.enable = mkEnableOption "nixos-mailserver service";
      mkm.enable = mkEnableOption "mkm-ticketing service";

      nextcloud = mkService {
        name = "Nextcloud";
        type = "cloud storage";
      };

      nginx = mkService {
        name = "Nginx";
        type = "webserver";
      };

      vaultwarden = mkService {
        name = "Vaultwarden";
        type = "password manager";
        port = 8222;
        host = "127.0.0.1";
      };

      forgejo = mkService {
        name = "Forgejo";
        type = "forge";
        port = 7000;
      };

      quassel = mkService {
        name = "Quassel";
        type = "IRC";
        port = 4242;
      };

      jellyfin = mkService {
        name = "Jellyfin";
        type = "media";
        port = 8096;
      };

      searxng = mkService {
        name = "Searxng";
        type = "meta search engine";
        port = 8888;
      };

      miniflux = mkService {
        name = "Miniflux";
        type = "RSS reader";
      };

      reposilite = mkService {
        name = "Reposilite";
        port = 8084;
      };

      elasticsearch = mkService {
        name = "Elasticsearch";
        port = 9200;
      };

      kanidm = mkService {
        name = "Kanidm";
        port = 8443;
      };

      invidious = mkService {
        name = "Invidious";
        host = "127.0.0.1";
        port = 3333;
      };

      zerobin = mkService {
        name = "Zerobin";
        type = "pastebin";
        host = "127.0.0.1";
        port = 1357;
      };

      suwayomi-server = mkService {
        name = "Suwayomi Server";
        type = "manga reader";
        host = "127.0.0.1";
        port = 4567;
      };

      adguard = mkService {
        name = "AdGuard";
        type = "DNS";
        host = "0.0.0.0"; #"127.0.0.1";
        port = 3003;
      };

      netdata = mkService {
        name = "Netdata";
        type = "monitoring";
        host = "127.0.0.1";
        port = 19999;
      };

      authelia = mkService {
        name = "Authelia";
        type = "authentication";
        host = "127.0.0.1";
        port = 9092;
      };

      ldap = mkService {
        name = "LDAP";
        type = "directory";
        host = "127.0.0.1";
        port = 17170;
      };

      jitsi-meet = mkService {
        name = "Jitsi Meet";
        type = "video conferencing";
        host = "127.0.0.1";
        port = 443;
      };
    };
  };
}
