{
  config = {
    home-manager.users.xi = {
      wayland.windowManager.hyprland.enable = true;
      services.dunst.enable = true;
      services.gammastep.enable = true;
      services.nextcloud-client.enable = true;
      programs = {
        rofi.enable = true;
        firefox.enable = true;
        thunderbird.enable = true;
        vscode.enable = true;
        mangohud.enable = false;
        swaylock.enable = true;
        mpv.enable = false;
      };
      gtk.enable = true;
    };

    modules.home.programs.clipboard.enable = true;
    modules.home.programs.hyprpaper.enable = true;
    modules.home.programs.spotify.enable = true;
    modules.home.programs.element.enable = false;
    modules.home.programs.discord.enable = false;
    modules.home.programs.webcord.enable = true;
    modules.home.programs.wlogout.enable = false;
    modules.home.exclusive.packages.enable = true;
    modules.home.programs.anyrun.enable = false;
  };
}
