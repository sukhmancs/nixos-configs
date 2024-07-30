{osConfig, ...}: let
  c = osConfig.modules.themes.colors;
in {
  services.mako = {
    enable = true;
    font = "Lexend 11";
    borderRadius = 8;
    padding = "8";
    borderSize = 5;
    backgroundColor = "#${c.base02}";
    borderColor = "#${c.base0E}";
    textColor = "#${c.base05}";
    progressColor = "#${c.base04}";
    defaultTimeout = 4000;
  };
}
