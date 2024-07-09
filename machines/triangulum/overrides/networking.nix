{lib, ...}: {
  config = {
    # services.qemuGuest.enable = lib.mkForce true;
    services.resolved.enable = lib.mkForce false; # use adguardhome for dns
    networking = {
      networkmanager.dns = lib.mkForce "none";
      nameservers = ["127.0.0.1"]; # adguardhome dns server
      defaultGateway = "102.209.85.225";
      defaultGateway6 = {
        address = "";
        interface = "eth0";
      };
      useDHCP = lib.mkForce true;
      useNetworkd = lib.mkForce false;
      dhcpcd.enable = lib.mkForce false;
      usePredictableInterfaceNames = lib.mkForce false;
      interfaces = {
        eth0 = {
          ipv4.addresses = [
            {
              address = "102.209.85.226";
              prefixLength = 27;
            }
          ];
          ipv6.addresses = [
            {
              address = "fe80::be24:11ff:fefe:a75d";
              prefixLength = 64;
            }
          ];
          ipv4.routes = [
            {
              address = "102.209.85.225";
              prefixLength = 32;
            }
          ];
          ipv6.routes = [
            {
              address = "";
              prefixLength = 128;
            }
          ];
        };
      };
    };
    services.udev.extraRules = ''
      ATTR{address}=="bc:24:11:fe:a7:5d", NAME="eth0"

    '';
  };
}
