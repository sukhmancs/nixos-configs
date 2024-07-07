{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  dev = config.modules.device;
in {
  config = mkIf dev.hasSound {
    boot.kernelParams = ["btusb"];

    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      #hsphfpd.enable = true;
      powerOnBoot = true;
      disabledPlugins = ["sap"];
      settings = {
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
          Experimental = true;
        };
      };
    };

    # https://nixos.wiki/wiki/Bluetooth
    services.blueman.enable = true;
  };
}
