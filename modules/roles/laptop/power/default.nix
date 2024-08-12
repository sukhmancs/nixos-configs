#
# Common power management settings
#
{
  config,
  pkgs,
  ...
}: let
  cfg = config.services;
  dev = config.modules.device;
in {
  imports = [./monitor.nix];

  config = {
    hardware.acpilight.enable = true;

    environment.systemPackages = with pkgs; [
      acpi
    ];

    services = {
      # handle ACPI events
      acpid = {
        enable = true;
        logEvents = true;
      };

      # Power state monitor. Switches Power profiles based on charging state.
      # Only enable if auto-cpufreq is disabled
      power-profiles-daemon.enable = !cfg.auto-cpufreq.enable;

      # temperature target on battery
      undervolt = {
        # only enable on intel devices
        enable = dev.cpu.type == "intel";
        tempBat = 65; # deg C
        package = pkgs.undervolt;
      };

      # superior power management
      auto-cpufreq.enable = true;

      # DBus service that provides power management support to applications.
      upower = {
        enable = true;
        percentageLow = 15;
        percentageCritical = 5;
        percentageAction = 3;
        criticalPowerAction = "Hibernate";
      };
    };

    boot = {
      kernelModules = ["acpi_call"];
      extraModulePackages = with config.boot.kernelPackages; [
        acpi_call
        cpupower
      ];
    };
  };
}
