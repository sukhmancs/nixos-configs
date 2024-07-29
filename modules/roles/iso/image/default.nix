{
  self,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) cleanSource mkImageMediaOverride;
in {
  # This will disable nixos-rebuild switch
  system.switch.enable = false;

  isoImage = let
    name = "${config.networking.hostName}-${pkgs.stdenv.hostPlatform.uname.processor}";
  in {
    # The name of our iso file: hostname-arch.iso
    isoName = mkImageMediaOverride "${name}.iso";

    # VolumeID is the name that appears during boot process: hostname-arch
    volumeID = mkImageMediaOverride "${name}";

    # Maximum compression
    squashfsCompression = "zstd -Xcompression-level 19"; # default uses gzip
    makeEfiBootable = true;

    # ISO image should be bootable from CD as well as USB.
    makeUsbBootable = true;

    # Get rid of "installer" suffix in boot menu
    appendToMenuLabel = "";

    contents = [
      {
        # Include memtest86+ in the ISO image
        source = pkgs.memtest86plus + "/memtest.bin";
        target = "/boot/memtest.bin";
      }
      {
        # link this flake to /etc/nixos/flake so that the user can
        # can initiate a rebuild without having to clone and wait
        # useful if this installer is meant to be used on a system
        # that cannot access github
        source = cleanSource self;
        target = "/root/nyx";
      }
    ];
  };
}
