{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;

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
      auto-cpufreq = {
        enable = true;
        # settings = let
        #   MHZ_to_KHZ = x: x * 1000;
        # in {
        #   battery = {
        #     governor = "powersave";
        #     energy_performance_preference = "power";
        #     scaling_min_freq = mkDefault (MHZ_to_KHZ 1400);
        #     scaling_max_freq = mkDefault (MHZ_to_KHZ 1800);
        #     turbo = "never";

        #     # Battery threshold - This is still experimental
        #     # enable_thresholds = true;
        #     # start_threshold = 40;
        #     # stop_threshold = 80;
        #   };

        #   charger = {
        #     governor = "performance";
        #     energy_performance_preference = "performance";
        #     scaling_min_freq = mkDefault (MHZ_to_KHZ 1800);
        #     scaling_max_freq = mkDefault (MHZ_to_KHZ 2300);
        #     turbo = "auto";
        #   };
        # };
      };

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

    # Battery threshold
    systemd.services.batterThreshold = {
      script = ''
        echo 80 | tee /sys/class/power_supply/BAT0/charge_control_end_threshold
      '';
      wantedBy = ["multi-user.target"];
      description = "Set the charge threshold to protect battery life";
      serviceConfig = {
        Restart = "on-failure";
      };
    };
  };
}
