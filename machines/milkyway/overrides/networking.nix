#
# Override the default settings
#
{lib, ...}: let
  inherit (lib) mkForce;
in {
  config = {
    services.resolved.enable = mkForce false; # use adguardhome for dns
    networking = {
      networkmanager.dns = mkForce "none";
      nameservers = ["102.209.85.226"]; # adguardhome dns server
    };
  };
}
