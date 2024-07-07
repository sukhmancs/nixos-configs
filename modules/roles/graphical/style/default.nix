#
# Stylix - System-Wide theme configuration
#
{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}: let
  cfg = config.modules.stylix;
in {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix.autoEnable = cfg.globalThemeEnable;
  stylix.polarity = cfg.polarity;
  stylix.image = pkgs.fetchurl {
    url = cfg.wallpaper.backgroundUrl;
    sha256 = cfg.wallpaper.backgroundSha256;
  };
  stylix.base16Scheme = cfg.theme.package;
  stylix.fonts = {
    monospace = {
      name = cfg.settings.font;
      package = cfg.settings.fontPkg;
    };
    serif = {
      name = cfg.settings.font;
      package = cfg.settings.fontPkg;
    };
    sansSerif = {
      name = cfg.settings.font;
      package = cfg.settings.fontPkg;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
