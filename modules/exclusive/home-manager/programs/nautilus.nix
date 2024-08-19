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
      packages = [
        pkgs.nautilus # File manager
        pkgs.nautilus-open-any-terminal # Open terminal in current directory
        pkgs.gnome.sushi # File previewer
      ];
    };
  };
}