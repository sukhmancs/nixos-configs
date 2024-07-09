{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  config = {
    networking.domain = "xilain.dev";
    services.smartd.enable = lib.mkForce false;
    boot = {
      growPartition = !config.boot.initrd.systemd.enable;
      initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi"];
      initrd.kernelModules = ["nvme"];
      loader.grub = {
        enable = true;
        useOSProber = lib.mkForce false;
        efiSupport = lib.mkForce false;
        enableCryptodisk = false;
        theme = null;
        # This option sets the background color of the system.
        # If set to null, the background color will be unset.
        backgroundColor = null;
        splashImage = null;
        device = lib.mkForce "/dev/vda";
        forceInstall = true;
      };

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
  };
}
