{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  gam = modules.home.gaming.lutris;
in {
  config = mkIf gam.enable {
    home.packages = [
      (pkgs.lutris.override {
        extraPkgs = p: [
          p.wineWowPackages.staging
          p.pixman
          p.libjpeg
          p.gnome.zenity
        ];
      })
    ];
  };
}