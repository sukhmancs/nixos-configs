{ config
, lib
, ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.joplin-desktop.enable {
    programs.joplin-desktop = {
      general.editor = null;
      extraConfig = {
        "markdown.plugin.mark" = true;
        newNoteFocus = "title";
      };
      sync = {
        interval = "10m";
        target = "onedrive";
      };
    };
  };
}
