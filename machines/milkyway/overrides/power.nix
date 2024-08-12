#
# Overrides:
# - battery - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
# - charger - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
#
{lib, ...}: let
  inherit (lib) mkForce mkDefault;
in {
  services.auto-cpufreq = {
    enable = mkForce true;
    settings = let
      MHZ_to_KHZ = x: x * 1000;
    in {
      battery = {
        governor = "powersave";
        # energy_performance_preference = "power"; # not supported by this host.
        scaling_min_freq = mkDefault (MHZ_to_KHZ 1400);
        scaling_max_freq = mkDefault (MHZ_to_KHZ 1700);
        turbo = "never";
      };

      charger = {
        governor = "performance";
        # energy_performance_preference = "performance"; # not supported by this host.
        scaling_min_freq = mkDefault (MHZ_to_KHZ 1700);
        scaling_max_freq = mkDefault (MHZ_to_KHZ 2300);
        turbo = "auto";
      };
    };
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
}

