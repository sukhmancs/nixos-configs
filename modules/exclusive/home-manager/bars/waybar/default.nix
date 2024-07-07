{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;

  waybar_config = import ./presets/config.nix {inherit osConfig config lib pkgs;};
  waybar_style = import ./presets/style.nix;
in {
  config = mkIf config.programs.waybar.enable {
    home.packages = with pkgs.python3Packages; [requests];
    programs.waybar = {
      systemd.enable = true;
      package = pkgs.waybar;
      settings = waybar_config;
      style = waybar_style;
    };
  };
}
