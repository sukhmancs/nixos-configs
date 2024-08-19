{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  gam = modules.home.gaming.factorio;
in {
  config = mkIf gam.enable {
    home = {
      packages = [pkgs.factorio];
    };
  };
}