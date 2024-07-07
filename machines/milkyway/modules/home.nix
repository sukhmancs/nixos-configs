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
        mangohud.enable = true;
        swaylock.enable = true;
        mpv.enable = true;
      };
      gtk.enable = true;
    };

    modules.home.programs.clipboard.enable = true;
    modules.home.programs.hyprpaper.enable = true;
    modules.home.programs.spotify.enable = true;
    modules.home.programs.element.enable = true;
    modules.home.programs.discord.enable = true;
    modules.home.programs.webcord.enable = true;
    modules.home.programs.wlogout.enable = true;
    modules.home.exclusive.packages.enable = true;
  };
}
