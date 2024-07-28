{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.printing.enable {
    # enable cups and add some drivers for common printers
    services = {
      printing = {
        drivers = with pkgs; [
          gutenprint
          hplip
        ];
      };

      # required for network discovery of printers
      # also required by geoclue2 to find my location
      # and in return gammastep to work as it relies on geoclue2
      avahi = {
        enable = true;
        # resolve .local domains for printers
        nssmdns4 = true;
        # pass avahi port(s) to the firewall
        openFirewall = true;
      };
    };
  };
}
