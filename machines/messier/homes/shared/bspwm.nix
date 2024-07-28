{...}: {
  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager = {
      bspwm = {
        enable = true;
        # monitors =
        #   if hostName == "beelink"
        #   then {
        #     ${mainMonitor} = ["1" "2" "3" "4" "5"];
        #     ${secondMonitor} = ["6" "7" "8" "9" "0"];
        #   }
        #   else {};
        rules = {
          # Window Rules (xprop)
          "Emacs" = {
            desktop = "3";
            follow = true;
            state = "tiled";
          };
          ".blueman-manager-wrapped" = {
            state = "floating";
            sticky = true;
          };
          "libreoffice" = {
            desktop = "3";
            follow = true;
          };
          "Lutris" = {
            desktop = "5";
            follow = true;
          };
          "Pavucontrol" = {
            state = "floating";
            sticky = true;
          };
          "Pcmanfm" = {
            state = "floating";
          };
          "plexmediaplayer" = {
            desktop = "4";
            follow = true;
            state = "fullscreen";
          };
          "*:*:Picture in picture" = {
            state = "floating";
            sticky = true;
          };
          "*:*:Picture-in-Picture" = {
            state = "floating";
            sticky = true;
          };
          "Steam" = {
            desktop = "5";
          };
        };
        #   extraConfig = extraConf;
      };
    };
  };
}
