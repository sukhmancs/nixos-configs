{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  config = {
    home.packages = [
      pkgs.polybar
    ];

    home.file.".config/polybar" = {
      source = ./config;
      recursive = true;
    };
  };
}
