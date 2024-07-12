#
# Wireguard Server Configuration
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.networking.wireguard.enable {
    networking = {
      nat = {
        enable = true;
        externalInterface = "eth0";
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
      interfaces = {
        wg0 = {
          # General settings
          privateKeyFile = config.age.secrets.wg-server.path;
          listenPort = 51820;

          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          # postSetup = ''
          #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
          # '';
          postSetup = ''
            ${pkgs.nftables}/bin/nft add table ip nat
            ${pkgs.nftables}/bin/nft add chain ip nat postrouting { type nat hook postrouting priority 100 \; }
            ${pkgs.nftables}/bin/nft add rule ip nat postrouting oifname "eth0" ip saddr 10.0.0.0/24 masquerade
          '';

          # This undoes the above command
          # postShutdown = ''
          #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
          # '';
          postShutdown = ''
            ${pkgs.nftables}/bin/nft flush chain ip nat postrouting
          '';

          # IPs
          ips = [
            "10.0.0.1/24"
            "fdc9:281f:04d7:9ee9::1/64"

            # "10.255.255.10/24" # v4 general
            # "10.255.255.254/24" # v4 adtl
            # "fe80::10/64" # v6 link local
            # "2a01:4f9:c010:2cf9:f::10/80" #v6 general
            # "2a01:4f9:c010:2cf9:f::ffff/80" #v6 adtl
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
                "10.0.0.2/32"
                "fdc9:281f:04d7:9ee9::2/128"
              ];
              publicKey = "T0y8gISdCvbgwH2wOinfX3YuiAfb7zuw20li7dzt1QU=";
            }
            # iphone
            {
              allowedIPs = [
                "10.0.0.3/32"
                "fdc9:281f:04d7:9ee9::3/128"
              ];
              publicKey = "7SUc29cwNgNsvNh95ffsRyQHadDehnO3aC4UHJ8DAXM=";
            }
          ];
        };
      };
    };
  };
}
