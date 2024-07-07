{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = [./config.nix];
  config = mkIf config.wayland.windowManager.sway.enable {
    wayland.windowManager.sway = {
      package = pkgs.swayfx;
    };
  };
}
