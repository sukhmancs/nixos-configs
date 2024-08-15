{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    services.dbus.apparmor = "enabled";

    # apparmor configuration
    security.apparmor = {
      enable = true;
      enableCache = true;

      # kill process that are not confined but have apparmor profiles enabled
      killUnconfinedConfinables = true;
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

    environment.systemPackages = with pkgs; [
      apparmor-bin-utils
      apparmor-profiles
      apparmor-parser
      libapparmor
      apparmor-kernel-patches
      apparmor-pam
      apparmor-utils
    ];
  };
}
