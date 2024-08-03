{config}: {
  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);
    useDHCP = false;
    useNetworkd = true;
    usePredictableInterfaceNames = true;
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
    search = [
      "xilain.dev"
      "xilain.xilain.dev"
    ];
  };
}
