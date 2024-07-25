{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.services.nextcloud-client.enable {
    home.packages = [pkgs.nextcloud-client];
    services = {
      nextcloud-client.startInBackground = true;
    };
  };
}
