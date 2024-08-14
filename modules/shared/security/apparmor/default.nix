# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  config,
  pkgs,
  lib,
  ...
}: let
  getLib = lib.getLib;
in {
  config = {
    services.dbus.apparmor = "enabled";

    environment.systemPackages = with pkgs; [
      apparmor-pam
      apparmor-utils
      apparmor-parser
      apparmor-profiles
      apparmor-bin-utils
      apparmor-kernel-patches
      libapparmor
    ];

    # apparmor configuration
    security.apparmor = {
      enable = true;

      # whether to enable the AppArmor cache
      # in /var/cache/apparmore
      enableCache = true;

      # whether to kill processes which have an AppArmor profile enabled
      # but are not confined (AppArmor can only confine new processes)
      killUnconfinedConfinables = true;

      # packages to be added to AppArmor’s include path
      packages = [pkgs.apparmor-profiles];

      #TODO: for some reason, these profiles are not being applied, even though they are loaded and enforced
      # apparmor policies
      policies = {
        "bin.chrome" = {
          enable = true;
          enforce = true;
          profile = builtins.readFile ./profiles/chrome;
        };
      };
    };
  };
}
