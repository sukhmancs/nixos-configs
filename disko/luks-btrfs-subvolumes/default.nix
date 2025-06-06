# Partition and mount the disk with a LUKS-encrypted Btrfs filesystem using disko
#
# Run this in the terminal:
# DISK='/dev/disk/by-id/ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K'
# curl https://raw.githubusercontent.com/sukhmancs/nixos-configs/main/disko//default.nix \
#     -o /tmp/disko.nix
# sed -i "s|to-be-filled-during-installation|$DISK|" /tmp/disko.nix
# nix --experimental-features "nix-command flakes" run github:nix-community/disko \
#     -- --mode disko /tmp/disko.nix
#
{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "to-be-filled-during-installation";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            plainSwap = {
              start = "1G";
              end = "9G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true; # resume from hiberation from this device
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true; # beware of write-pattern attacks
                  #keyFile = "/tmp/secret.key";
                };
                # Whether to add a boot.initrd.luks.devices entry for the specified disk.
                initrdUnlock = true;

                # encrypt the root partition with luks2 and argon2id, will prompt for a passphrase, which will be used to unlock the partition.
                # cryptsetup luksFormat
                extraFormatArgs = [
                  "--type luks2"
                  "--cipher aes-xts-plain64"
                  "--hash sha512"
                  "--iter-time 5000"
                  "--key-size 256"
                  "--pbkdf argon2id"
                  # use true random data from /dev/random, will block until enough entropy is available
                  "--use-random"
                ];
                extraOpenArgs = [
                  "--timeout 10"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Force override existing partition
                  subvolumes = {
                    "root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "snapshots" = {
                      mountpoint = "/snapshots";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "log" = {
                      mountpoint = "/var/log";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
