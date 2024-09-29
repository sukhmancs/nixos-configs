{ osConfig
, pkgs
, config
, lib
, ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in
{
  config = mkIf config.programs.swaylock.enable {
    # Gradually dim the screen on Wayland
    home.packages = [
      pkgs.chayang
    ];

    programs.swaylock = {
      package = pkgs.swaylock-effects;
      settings = {
        effect-blur = "20x3";
        fade-in = 0.1;

        line-uses-inside = true;
        disable-caps-lock-text = true;
        indicator-caps-lock = true;
        indicator-radius = 40;
        indicator-idle-visible = true;
        indicator-y-position = 1000;

        clock = true;
        color = "${colors.base00}";
        font = "Work Sans";
        font-size = 15;
        show-failed-attempts = false;
        indicator = true;
        #indicator-thickness = 20;
        line-color = "${colors.base00}";
        ring-color = "${colors.base04}";
        inside-color = "${colors.base00}";
        key-hl-color = "${colors.base0E}";
        separator-color = "00000000";
        text-color = "${colors.base05}";
        text-caps-lock-color = "";
        line-ver-color = "${colors.base0F}";
        ring-ver-color = "${colors.base0F}";
        inside-ver-color = "${colors.base00}";
        text-ver-color = "${colors.base05}";
        ring-wrong-color = "${colors.base08}";
        text-wrong-color = "${colors.base08}";
        inside-wrong-color = "${colors.base00}";
        inside-clear-color = "${colors.base00}";
        text-clear-color = "${colors.base05}";
        ring-clear-color = "${colors.base0B}";
        line-clear-color = "${colors.base00}";
        line-wrong-color = "${colors.base00}";
        bs-hl-color = "${colors.base08}";
        line-uses-ring = false;
        #grace = 3;
        #grace-no-mouse = true;
        #grace-no-touch = true;
        datestr = "%d/%m/%Y";
        #ignore-empty-password = true;
      };
    };
  };
}
