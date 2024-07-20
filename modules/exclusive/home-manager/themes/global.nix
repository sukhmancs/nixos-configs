{
  osConfig,
  pkgs,
  ...
}: {
  # cursor theme
  home = {
    pointerCursor = {
      package = "pkgs.bibata-cursors"; # pkgs.catppuccin-cursors.mochaDark;
      name = "bibata-cursors"; # "catppuccin-mocha-dark-cursors";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
