{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.virtualisation.podman.enable {
    environment.systemPackages = with pkgs; [
      podman-compose
      podman-desktop
    ];

    virtualisation.podman = {
      # make docker backwards compatible with docker interface
      # certain interface elements will be different, but unless hardcoded
      # does not cause problems for us
      dockerCompat = true;
      dockerSocket.enable = true;

      defaultNetwork.settings.dns_enabled = true;

      # enable nvidia support if any of the video drivers are nvidia
      enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;

      # prune images and containers periodically
      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
