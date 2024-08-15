# jebait agressive port scanners by wasting their time with connection that'll never make it in
# this *does* have performance implications, however, so be careful which hosts you enable it for
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.endlessh-go.enable {
    services.endlessh-go = {
      port = 22;
      openFirewall = true;

      extraOptions = [
        "-alsologtostderr"
        "-geoip_supplier max-mind-db"
        "-max_mind_db ${pkgs.clash-geoip}/etc/clash/Country.mmdb"
      ];

      prometheus = {
        enable = true;
        port = 9105;
      };
    };
  };
}
