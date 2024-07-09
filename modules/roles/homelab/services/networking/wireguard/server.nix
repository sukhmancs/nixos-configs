#
# Wireguard Server Configuration
#
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf false {
    networking = {
      nat = {
        enable = true;
        externalInterface = "ens3";
        internalInterfaces = ["wg0"];
      };

      firewall = {
        allowedUDPPorts = [51820];
        trustedInterfaces = ["wg0"];
      };
    };

    boot.kernelModules = [
      "wireguard"
    ];

    networking.wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          # General settings
          privateKeyFile = config.age.secrets.wg-server.path;
          listenPort = 51820;

          # IPs
          ips = [
            "10.255.255.10/24" # v4 general
            "10.255.255.254/24" # v4 adtl
            "fe80::10/64" # v6 link local
            "2a01:4f9:c010:2cf9:f::10/80" #v6 general
            "2a01:4f9:c010:2cf9:f::ffff/80" #v6 adtl
          ];

          # Peers
          peers = [
            # hermes
            {
              allowedIPs = [
                "10.255.255.11/32"
                "fe80::11/128"
                "2a01:4f9:c010:2cf9:f::11/128"
              ];
              publicKey = "9BtqBu73BFTkYew/x3spLtvNmCSLrZrjfuToag84jjA=";
            }
            # android
            {
              allowedIPs = [
                "10.0.0.2/24"
              ];
              publicKey = "T0y8gISdCvbgwH2wOinfX3YuiAfb7zuw20li7dzt1QU=";
            }
            # iphone
            {
              allowedIPs = [
                "10.0.0.3/32"
              ];
              publicKey = "7SUc29cwNgNsvNh95ffsRyQHadDehnO3aC4UHJ8DAXM=";
            }
          ];
        };
      };
    };
  };
}
