{
  config = {
    home-manager.users.xi = {
      wayland.windowManager.hyprland.enable = true; # window manager
      services.dunst.enable = true; # notification daemon
      services.gammastep.enable = false; # display color control #TODO: not working
      services.nextcloud-client.enable = true; # syncronization client
      services.swayidle.enable = true; # screen idle
      programs = {
        rofi.enable = true; # application launcher
        firefox.enable = true; # browser (schizofox)
        thunderbird.enable = true; # email client
        vscode.enable = true; # code editor
        zathura.enable = true; # pdf reader
        mangohud.enable = false; # game overlay
        swaylock.enable = true; # screen locker
        mpv.enable = true; # media player
      };
      gtk.enable = true; # gtk theme
      qt.enable = true; # qt theme with kvantum
    };

    modules.home.programs = {
      ags.enable = true; # widgets
      clipboard.enable = true;
      hyprpaper.enable = true; # wallpaper manager
      spotify.enable = true; # music player
      element.enable = true; # matrix client
      discord.enable = false;
      webcord.enable = true; # privacy respecting discord client
      wlogout.enable = true; # logout menu
      anyrun.enable = true; # application launcher
      rbw.enable = true; # bitwarden password manager using rofi
    };

    modules.home.exclusive.packages.enable = true; # other packages
  };
}
