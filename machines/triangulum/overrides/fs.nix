#
# fs - Disable BTRFS autoscrub for server because server is not using BTRFS FileSystem
#
{lib, ...}: let
  inherit (lib) mkForce;
in {
  config = {
    services = {
      btrfs.autoScrub = {
        enable = mkForce false;
        interval = "weekly";
        fileSystems = ["/"];
      };
    };
  };
}
