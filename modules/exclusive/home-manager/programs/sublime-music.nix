{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.home.programs.sublime-music;
in {
  config = mkIf prg.enable {
    home.packages = [pkgs.sublime-music];
  };
}