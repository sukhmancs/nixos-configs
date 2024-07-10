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
        # Background color to be used for GRUB to fill the areas the image isn’t filling
        backgroundColor = null;
        splashImage = null;
        device = lib.mkForce "/dev/vda";
        forceInstall = true;
      };

      tmp = {
        useTmpfs = lib.mkForce false;
        cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
        tmpfsSize = lib.mkDefault "75%";
      };
    };
  };
}
