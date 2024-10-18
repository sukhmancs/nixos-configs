{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.programs.joplin-desktop.enable {
    programs.joplin-desktop = {
      package = pkgs.joplin-desktop;
      general.editor = null;
      extraConfig = {
        "markdown.plugin.mark" = true;
        newNoteFocus = "title";
        "themeAutoDetect" = true;
      };
      sync = {
        interval = "5m";
        target = "onedrive";
      };
    };
  };
}
