{
  config.modules.system.services = {
    nextcloud.enable = true;
    mailserver.enable = true;
    vaultwarden.enable = true;
    forgejo.enable = true;
    searxng.enable = true;
    reposilite.enable = false;
    invidious.enable = true;
    suwayomi-server.enable = true;
    adguard.enable = true;
    netdata.enable = true;
    authelia.enable = true;
    jitsi-meet.enable = false; #FIXME: Remove jitsi-meet as i was unable to find a way for jitsi-meet to listen on different port other than 443. I am already serving my own website on that port.And that is where nginx is listening

    homelab = {
      homepage.enable = true;
    };

    social = {
      mastodon.enable = true;
      matrix.enable = true;
    };

    bincache = {
      harmonia.enable = true;
    };

    networking = {
      # headscale.enable = true;
      wireguard.enable = true;
    };

    monitoring = {
      grafana.enable = true;
      prometheus.enable = true;
      loki.enable = false;
      uptime-kuma.enable = true;
    };

    database = {
      mysql.enable = false;
      mongodb.enable = false;
      redis.enable = true;
      postgresql.enable = true;
      garage.enable = true;
    };
  };
}
