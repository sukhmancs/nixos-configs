{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce mkAfter mkImageMediaOverride;
in {
  boot = {
    # Force systemd-boot to be disabled.
    loader.systemd-boot.enable = mkForce false;

    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Kernel parameters
    # "noquiet" shows more boot messages, useful for debugging
    # "toram" loads the entire system into RAM, improving performance for a live environment
    kernelParams = mkAfter ["noquiet" "toram"];

    # Wou don't need systemd in the initrd stage
    initrd.systemd = {
      enable = mkImageMediaOverride false;
      emergencyAccess = mkImageMediaOverride false;
    };

    # This are the filesystems that will be supported by the installer
    supportedFilesystems = mkForce [
      "btrfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];

    # RAID means Redundant Array of Independent Disks and is used to combine
    # multiple disks into a single logical unit to improve performance and
    # redundancy. This is not needed for an installer environment.
    swraid.enable = mkForce false;
  };
}
