{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    boot = {
      loader.systemd-boot.enable = true;
      plymouth.enable = true;

      tmp = {
        # /tmp on tmpfs, lets it live on your ram
        # it defaults to FALSE, which means you will use disk space instead of ram
        # enable tmpfs tmp on anything except servers and builders
        useTmpfs = lib.mkForce false;

        # If not using tmpfs, which is naturally purged on reboot, we must clean
        # /tmp ourselves. /tmp should be volatile storage!
        cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);

        # The size of the tmpfs, in percentage form
        # this defaults to 50% of your ram, which is a good default
        # but should be tweaked based on your systems capabilities
        tmpfsSize = lib.mkDefault "75%";
      };
    };

    # services.seatd.enable = true;
    xdg.portal.enable = true;
    services.tailscale.enable = false; #TODO setup headscale first

    modules.system = {
      mainUser = "xi";
      impermanence.root.enable = true;

      encryption = {
        enable = true;
        device = "enc";
      };
    };
  };
}
