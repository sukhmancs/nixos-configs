{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.home.programs = {
    anyrun.enable = mkEnableOption {
      default = false;
      description = "Application runner";
    };

    ags.enable = mkEnableOption {
      default = false;
      description = "Enable AGS";
    };

    rbw.enable = mkEnableOption {
      default = false;
      description = "Enable Bitwarden CLI (rbw)";
    };

    clipboard.enable = mkEnableOption {
      default = false;
      description = "Enable clipboard service";
    };

    discord.enable = mkEnableOption {
      default = false;
      description = "Enable Discord";
    };

    webcord.enable = mkEnableOption {
      default = false;
      description = "Enable Webcord";
    };

    element.enable = mkEnableOption {
      default = false;
      description = "Enable Element";
    };

    hyprpaper.enable = mkEnableOption {
      default = false;
      description = "Wallpaper manager";
    };

    libreoffice.enable = mkEnableOption {
      default = false;
      description = "Enable LibreOffice";
    };

    spotify.enable = mkEnableOption {
      default = false;
      description = "Enable Spotify";
    };

    wlogout.enable = mkEnableOption {
      default = false;
      description = "Enable Wlogout";
    };

    waypipe.enable = mkEnableOption {
      default = false;
      description = "Wayland over SSH";
    };

    sublime-music.enable = mkEnableOption {
      default = false;
      description = "Music player";
    };

    nautilus.enable = mkEnableOption {
      default = false;
      description = "Enable Gnome File Manager";
    };

    schizofox.enable = mkEnableOption {
      default = false;
      description = "Enable Schizofox";
    };
  };
}
