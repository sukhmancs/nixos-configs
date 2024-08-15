#
# rofi-rbw - A rofi frontend for Bitwarden
#
{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;
  prg = modules.home.programs;

  # Configuration options for rofi-rbw
  rofiRbwConfig = {
    action = ["type"]; # default, copy, print
    target = ["username" "password"]; # Can include "notes", "totp", or any custom field
    prompt = ["Bitwarden"]; # Custom prompt text
    clear-after = ["15"]; # Clear the clipboard after 15 seconds
    # keybindings = ["Alt+1:type:username:enter:delay:password:enter"]; # Custom keybindings
  };

  # Convert the configuration to a format suitable for the rofi-rbw.rc file
  configText = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "${name}=${lib.concatStringsSep "," value}") rofiRbwConfig);
in {
  config = mkIf (config.programs.rofi.enable && prg.rbw.enable) {
    home.packages = with pkgs; [
      rbw
      rofi-rbw
      wl-clipboard
      wtype
    ];

    # Write the rofi-rbw configuration file
    home.file.".config/rofi-rbw.rc".text = configText;
  };
}
