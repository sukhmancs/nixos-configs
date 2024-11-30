{
  config = {
    home-manager.users.xi = {
      wayland.windowManager.hyprland.enable = true; # window manager
      services.dunst.enable = true; # notification daemon
      services.gammastep.enable = true; # display color control
      services.nextcloud-client.enable = true; # syncronization client
      services.swayidle.enable = true; # screen idle
      services.polybar.enable = true; # status bar
      # services.mpd.enable = true; # music player daemon
      programs = {
        rofi.enable = true; # application launcher
        joplin-desktop.enable = true; # my favorite note taker
        chromium.enable = true; # browser
        firefox.enable = true; # browser
        thunderbird.enable = true; # email client
        vscode.enable = true; # code editor
        zathura.enable = true; # pdf reader
        swaylock.enable = true; # screen locker
        mpv.enable = true; # media player
        # ncmpcpp.enable = true; # music player client for mpd
        kitty.enable = false; # terminal emulator
        mangohud.enable = false; # game overlay
      };
      gtk.enable = true; # gtk theme
      qt.enable = true; # qt theme with kvantum
    };

    modules.home.programs = {
      # ags.enable = true; # widgets # TODO: need to upgrade to v2
      # schizofox.enable = true; # browser
      clipboard.enable = true; # clipboard manager
      hyprpaper.enable = true; # wallpaper manager
      webcord.enable = true; # privacy respecting discord client
      wlogout.enable = true; # logout menu
      anyrun.enable = true; # application launcher
      rbw.enable = true; # bitwarden password manager using rofi
      waypipe.enable = true; # wayland over ssh
      sublime-music.enable = true; # music player
      spotify.enable = true; # music player
      element.enable = true; # matrix client
      discord.enable = false;
      nautilus.enable = false; # file manager
    };

    modules.home.gaming = {
      starcitizen.enable = false; # game
      runescape.enable = false; # game
      factorio.enable = false; # game
      lutris.enable = false; # game manager
    };

    modules.home.exclusive.packages.enable = true; # other packages that i need
  };
}
