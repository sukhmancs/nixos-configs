{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.home.programs.nautilus;
in {
  config = mkIf prg.enable {
    home = {
      packages = [pkgs.nautilus];
    };

    # Enable the Open Any Terminal extension
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "$TERMINAL";
    };

    # Enable the Sushi file previewer
    services.gnome.sushi.enable = true;
  };
}