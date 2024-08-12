#
# Overrides:
# - battery - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
# - charger - governor, energy_performance_preference, scaling_min_freq, scaling_max_freq, turbo
#
{lib, ...}:
let
  inherit (lib) mkForce mkDefault;
in
{
  services.auto-cpufreq = {
        enable = mkForce true;
        settings = let
          MHZ_to_KHZ = x: x * 1000;
        in {
          battery = {
            governor = "powersave";
            # energy_performance_preference = "power"; # not supported by this host.
            scaling_min_freq = mkDefault (MHZ_to_KHZ 1400);
            scaling_max_freq = mkDefault (MHZ_to_KHZ 1800);
            turbo = "never";

            # Battery threshold - This is still experimental
            # enable_thresholds = true;
            # start_threshold = 40;
            # stop_threshold = 80;
          };

          charger = {
            governor = "performance";
            # energy_performance_preference = "performance"; # not supported by this host.
            scaling_min_freq = mkDefault (MHZ_to_KHZ 1800);
            scaling_max_freq = mkDefault (MHZ_to_KHZ 2300);
            turbo = "auto";
          };
        };
      };
}