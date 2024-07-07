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
    services = {
      nextcloud-client.startInBackground = true;
    };
  };
}
