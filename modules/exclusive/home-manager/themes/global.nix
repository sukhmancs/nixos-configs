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
      package = pkgs.catppuccin-cursors.mochaDark; # pkgs.bibata-cursors;
      name = "catppuccin-mocha-dark-cursors"; # "bibata-cursors";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
