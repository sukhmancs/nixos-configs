{lib, ...}:{
  networking = {
    networkmanager = {
      ethernet.macAddress = lib.mkDefault "random";
      wifi = {
        macAddress = lib.mkDefault "random";
        scanRandMacAddress = lib.mkDefault true;
      };
      # Enable IPv6 privacy extensions in NetworkManager.
      connectionConfig."ipv6.ip6-privacy" = lib.mkDefault 2;
    };
  };

  # Enable IPv6 privacy extensions for systemd-networkd.
  systemd.network.config.networkConfig.IPv6PrivacyExtensions = lib.mkDefault "kernel";
}