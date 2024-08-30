{
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (osConfig) home;
in {
  programs.btop = {
    enable = true;
    package = pkgs.btop;
    settings = {
      color_theme = "custom";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default gpu0:0:tty,gpu1:1:tty,gpu2:0:tty,gpu3:1:tty,gpu4:0:tty,gpu5:1:tty";
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "tty"; # Other options are "braille", "block";
      graph_symbol_cpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";
      shown_boxes = "proc cpu mem net";
      update_ms = 1500;
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = true;
      proc_per_core = true;
      proc_mem_bytes = true;
      proc_info_smaps = false;
      proc_left = false;
      cpu_graph_upper = "total";
      cpu_graph_lower = "total";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = true;
      cpu_core_map = "";
      temp_scale = "celsius";
      base_10_sizes = false;
      show_cpu_freq = true;
      clock_format = "%H:%M";
      background_update = true;
      custom_cpu_name = "";
      disks_filter = "exclude=/boot";
      mem_graphs = true;
      mem_below_net = false;
      zfs_arc_cached = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = false;
      disk_free_priv = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;
      io_graph_speeds = "";
      net_download = 100;
      net_upload = 100;
      net_auto = true;
      net_sync = false;
      net_iface = "br0";
      show_battery = true;
      selected_battery = "Auto";
      log_level = "DEBUG";
    };
  };

  # home.file.".config/btop/themes/custom.theme" = {
  #   text = import ./themes.nix {inherit pkgs osConfig;};
  # };

  home.immutable-file = {
    btop-theme = {
      # src = builtins.toFile "custom.theme" (import ./themes.nix {inherit pkgs osConfig;});
      src = ./themes.nix;
      dst = "${config.xdg.configHome}/btop/themes/custom.theme";
    };
  };
}
