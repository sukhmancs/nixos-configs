#
# Overrides:
# - battery - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
# - charger - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
#
# Note:
# Check your available frequency steps that are supported by your cpu by running `cpufreq-info`.
# Your scaling_min_freq to scaling_max_freq range should be based on these steps.
# For this host:  available frequency steps: 2.30 GHz, 1.70 GHz, 1.40 GHz
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
  # This is not a portable workstation, so we can use battery threshold to improve battery life.
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
