{
  self',
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) plymouth;
  inherit (lib) mkIf;
in {
  config = mkIf config.boot.plymouth.enable {
    # configure plymouth theme
    # <https://github.com/adi1090x/plymouth-themes>
    boot.plymouth = let
      pack = 3;
      theme = "hud_3";
    in {
      themePackages = [(self'.packages.plymouth-themes.override {inherit pack theme;})];

      inherit theme;
    };

    # make plymouth work with sleep
    powerManagement = {
      powerDownCommands = ''
        ${plymouth} --show-splash
      '';
      resumeCommands = ''
        ${plymouth} --quit
      '';
    };
  };
}
