{
  osConfig,
  pkgs,
  ...
}: {
  # cursor theme
  home = {
    pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
