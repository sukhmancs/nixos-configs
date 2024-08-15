#
# Custom themes for the btop program.
#
{
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in ''
  # Colors should be in 6 or 2 character hexadecimal or single spaced rgb decimal: "#RRGGBB", "#BW" or "0-255 0-255 0-255"
  # example for white: "#ffffff", "#ff" or "255 255 255".

  # All graphs and meters can be gradients
  # For single color graphs leave "mid" and "end" variable empty.
  # Use "start" and "end" variables for two color gradient
  # Use "start", "mid" and "end" for three color gradient

  # Main background, empty for terminal default, need to be empty if you want transparent background
  theme[main_bg]=""

  # Main text color
  theme[main_fg]="#${colors.base05}"

  # Title color for boxes
  theme[title]="#${colors.base05}"

  # Highlight color for keyboard shortcuts
  theme[hi_fg]="#${colors.base0E}"

  # Background color of selected item in processes box
  theme[selected_bg]="#${colors.base0E}"

  # Foreground color of selected item in processes box
  theme[selected_fg]="#${colors.base00}"

  # Color of inactive/disabled text
  theme[inactive_fg]="#${colors.base03}"

  # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
  theme[proc_misc]="#${colors.base0E}"

  # Cpu box outline color
  theme[cpu_box]="#${colors.base0E}"

  # Memory/disks box outline color
  theme[mem_box]="#${colors.base0E}"

  # Net up/down box outline color
  theme[net_box]="#${colors.base0E}"

  # Processes box outline color
  theme[proc_box]="#${colors.base0E}"

  # Box divider line and small boxes line color
  theme[div_line]="#${colors.base03}"

  # Temperature graph colors
  theme[temp_start]="#${colors.base0E}"
  theme[temp_mid]="#d4d400"
  theme[temp_end]="#ff0040"

  # CPU graph colors
  theme[cpu_start]="#${colors.base0E}"
  theme[cpu_mid]="#d4d400"
  theme[cpu_end]="#ff0040"

  # Mem/Disk free meter
  theme[free_start]="#${colors.base0E}"
  theme[free_mid]="#1090a0"
  theme[free_end]="#206f79"

  # Mem/Disk cached meter
  theme[cached_start]="#991199"
  theme[cached_mid]="#770a55"
  theme[cached_end]="#550055"

  # Mem/Disk available meter
  theme[available_start]="#00b0ff"
  theme[available_mid]="#1099cc"
  theme[available_end]="#2070aa"

  # Mem/Disk used meter
  theme[used_start]="#ff0040"
  theme[used_mid]="#ff2060"
  theme[used_end]="#ff4080"

  # Download graph colors
  theme[download_start]="#${colors.base0E}"
  theme[download_mid]="#991199"
  theme[download_end]="#ff0040"

  # Upload graph colors
  theme[upload_start]="#${colors.base0E}"
  theme[upload_mid]="#991199"
  theme[upload_end]="#ff0040"
''
