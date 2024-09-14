#
# Cursor theme
#
{
  osConfig,
  pkgs,
  ...
}: {
  home = {
    pointerCursor = {
      package = pkgs.bibata-cursors; # pkgs.catppuccin-cursors.mochaDark;
      name = "Bibata-Modern-${
        if osConfig.modules.themes.polarity == "dark"
        then "Classic"
        else "Ice"
      }";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
