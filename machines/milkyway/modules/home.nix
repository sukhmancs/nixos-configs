{
  config = {
    home-manager.users.xi = {
      wayland.windowManager.hyprland.enable = true;
      services.dunst.enable = false; # ags will handle notifications
      services.gammastep.enable = true;
      services.nextcloud-client.enable = true;
      programs = {
        rofi.enable = true;
        firefox.enable = true;
        thunderbird.enable = true;
        vscode.enable = true;
        mangohud.enable = false;
        swaylock.enable = true;
        mpv.enable = true;
      };
      gtk.enable = true;
      qt.enable = true; #TODO - fix this
    };

    modules.home.programs = {
      ags.enable = true;
      clipboard.enable = true;
      hyprpaper.enable = true;
      spotify.enable = false;
      element.enable = false;
      discord.enable = false;
      webcord.enable = true;
      wlogout.enable = false;
      anyrun.enable = true;
      rbw.enable = true;
    };

    modules.home.exclusive.packages.enable = true;
  };
}
