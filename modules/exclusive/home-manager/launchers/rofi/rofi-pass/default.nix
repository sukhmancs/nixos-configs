{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.programs.rofi.enable {
    programs = {
      rofi = {
        pass = {
          enable = true;
          package = pkgs.rofi-pass-wayland; # default
        };
      };
    };

    home.file.".config/rofi-pass" = {
      source = ./rofi-pass-config;
      recursive = true;
    };
  };
}
