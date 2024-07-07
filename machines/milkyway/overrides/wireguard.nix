{config, ...}: {
  networking.firewall = {
    allowedUDPPorts = [51820];
  };

  boot.kernelModules = ["wireguard"];
  # hermes public key: 9BtqBu73BFTkYew/x3spLtvNmCSLrZrjfuToag84jjA=
  # Wireguard Client Peer Setup
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        # General Settings
        privateKeyFile = config.age.secrets.wg-client.path;
        allowedIPsAsRoutes = true;
        listenPort = 51820;
        ips = ["10.255.255.11/32" "2a01:4f9:c010:2cf9:f::11/128"];
        peers = [
          {
            allowedIPs = ["10.255.255.10/24" "2a01:4f9:c010:2cf9:f::/80"];
            endpoint = "102.209.85.226:51820";
            publicKey = "8Yo4FdRhwA6CftVb7unpdxT+bxw+IRq/al7yinHewDQ=";
            persistentKeepalive = 30;
          }
        ];
      };
    };
  };
}
