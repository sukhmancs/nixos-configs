{
  imports = [
    ./databases # mysql, postgreqsl, redis and more
    ./nginx # base nginx webserver configuration
    ./homepage-dashboard # homepage dashboard
    ./monitoring # prometheus, grafana, loki and uptime-kuma

    ./nextcloud.nix # cloud storage (not a backup solution)
    ./vaultwarden.nix # bitwarden compatible password manager
    ./mailserver.nix # nixos-mailserver setup
    ./searxng.nix # searx search engine
    ./suwayomi-server.nix # manga reader server
    ./adguard.nix # adguard home dns server
    ./lldap.nix # authentication server
    ./authelia.nix # authelia authentication server
  ];
}
