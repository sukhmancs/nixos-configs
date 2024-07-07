#
# Stylix - Theme options for stylix
#
{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) either listOf package str int bool;
in {
  options.modules.stylix = {
    theme = {
      name = mkOption {
        type = str;
        default = "Gruvbox Dark Hard";
        description = "The name for the Stylix theme package";
      };

      package = mkOption {
        type = package;
        description = "The theme package to be used for GTK programs";
        default = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      };
    };

    polarity = mkOption {
      type = str;
      default = "dark";
      description = "The polarity of the theme";
    };

    wallpaper = {
      backgroundUrl = mkOption {
        type = str;
        default = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        description = "The URL of the background image";
      };

      backgroundSha256 = mkOption {
        type = str;
        default = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
        description = "The SHA 256 hash of the background image";
      };
    };

    globalThemeEnable = mkOption {
      type = bool;
      default = false;
      description = "Whether to enable stylix globally";
    };

    # create an option that acceps the name of the target and it will create a target for it
    targets = mkOption {
      type = listOf str;
      default = ["lightdm" "console"];
      description = "The targets to enable";
    };

    settings = {
      font = mkOption {
        type = str;
        default = "Intel One Mono";
        description = "The font to use";
      };

      fontPkg = mkOption {
        type = package;
        default = pkgs.intel-one-mono;
        description = "The font package to use";
      };
    };
  };
}
