{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.tor.enable {
    services = {
      tor = {
        settings = {
          AutomapHostsOnResolve = true;
          AutomapHostsSuffixes = [".exit" ".onion"];
          EnforceDistinctSubnets = true;
          ExitNodes = "{de}";
          EntryNodes = "{de}";
          NewCircuitPeriod = 120;
          DNSPort = 9053; #TODO: use my own adguard home dns
          BandWidthRate = "15 MBytes";
        };

        relay.onionServices = {
          # hide ssh from script kiddies
          ssh = {
            version = 3;
            map = [{port = builtins.elemAt config.services.openssh.ports 0;}];
          };
        };
      };
    };
  };
}
