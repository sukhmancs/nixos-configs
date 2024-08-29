#
# BTRBK - Btrfs Backup
#
# This will create snapshots on schedule but we can also use `btrbk run` command to create a backup manually.
#
# To restore a snapshot:
#  - Locate the snapshot you want to restore in /snapshots
#  - Remove the current subvolume with `btrfs subvol delete /persist`
#  - Restore the snapshot with `btrfs subvol snapshot /snapshots/2024-08-28 /persist`
#  - Changes will be visible after a reboot or remounting the filesystem
#
{
  services.btrbk.instances.btrbk = {
    # btrbk will run every Tuesday, Thursday, and Saturday at 3:45:20
    onCalendar = "Tue,Thu,Sat *-*-* 3:45:20";
    settings = {
      # preserve snapshots for 9 days
      snapshot_preserve = "9d";
      snapshot_preserve_min = "2d";
      # keep daily backups for 9 days, weekly backups for 4 weeks, and monthly backups for 2 months
      target_preserve = "9d 4w 2m";
      target_preserve_min = "no";

      snapshot_dir = "/snapshots";
      subvolume = "/persist";

      # these are the subvolumes that will be backed up
      # volume = {
      #   "/" = {
      #     subvolume = {
      #       "persist" = {
      #         snapshot_create = "always";
      #       };
      #     };
      #   };
      # };
    };
  };
}
