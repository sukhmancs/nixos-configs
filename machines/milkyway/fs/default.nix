{
  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/fa8a6d23-2705-4ff4-8f17-8e4dafe952cd";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7251-418B";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      neededForBoot = true;
      options = ["subvol=persist" "compress=zstd" "noatime"];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      neededForBoot = true;
      options = ["subvol=log" "compress=zstd" "noatime"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };

    "/snapshots" = {
      device = "/dev/disk/by-uuid/7a241289-8c59-41dc-87bf-3453e4106dda";
      fsType = "btrfs";
      neededForBoot = true;
      options = ["subvol=snapshots" "compress=zstd" "noatime"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/2e2244b9-2ce2-4763-88a4-db2298e3e59b";}
  ];
}
