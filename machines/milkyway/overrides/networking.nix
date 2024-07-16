#
# Override the default settings
#
{lib, ...}: let
  inherit (lib) mkForce;
in {
  config = {
    services.resolved.enable = mkForce false; # use adguardhome for dns
    networking = {
      useDHCP = mkForce false;
      useNetworkd = mkForce false;
      networkmanager.dns = mkForce "default";
      nameservers = mkForce ["102.209.85.226"]; # adguardhome dns server
    };
  };
}
