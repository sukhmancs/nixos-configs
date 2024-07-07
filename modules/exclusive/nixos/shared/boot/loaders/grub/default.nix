{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf;
in {
  config = mkIf config.boot.loader.grub.enable {
    boot.loader = {
      grub = {
        useOSProber = true;
        efiSupport = true;
        enableCryptodisk = mkDefault false;
        device = "nodev"; # default - change according to your system
        theme = null;
        backgroundColor = null;
        splashImage = null;
      };
    };
  };
}
