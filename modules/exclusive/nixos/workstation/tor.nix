{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.tor.enable {
    services = {
      tor = {
        torsocks.enable = true;
        client = {
          enable = true;
          dns.enable = true;
        };
      };

      networkd-dispatcher = {
        enable = true;
        rules."restart-tor" = {
          onState = ["routable" "off"];
          script = ''
            #!${pkgs.runtimeShell}
            if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
              echo "Restarting Tor ..."
              systemctl restart tor
            fi
            exit 0
          '';
        };
      };
    };

    programs.proxychains = {
      enable = true;
      quietMode = false;
      proxyDNS = true;
      package = pkgs.proxychains-ng;
      proxies = {
        tor = {
          type = "socks5";
          host = "127.0.0.1";
          port = 9050;
        };
      };
    };
  };
}
