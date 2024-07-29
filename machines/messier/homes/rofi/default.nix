#
# Rofi - rofi with wayland plugins
#
{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkForce;

  # rofiTheme = pkgs.writeText "andromeda.rasi" (import ./rasi.nix {inherit osConfig;});
  rofiTheme = import ./rasi.nix {inherit osConfig pkgs;};
  # rofiRasi = pkgs.writeText "rofi.rasi" rofiThemePath;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override {
      plugins = with pkgs; [
        (rofi-calc.override {
          rofi-unwrapped = rofi-wayland-unwrapped;
        })
        (rofi-emoji.override {
          rofi-unwrapped = rofi-wayland-unwrapped;
        })
      ];
    };
    font = mkForce "Iosevka Nerd Font 14";
    extraConfig = mkForce {
      modi = "drun,calc,emoji,filebrowser";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      sidebar-mode = true;
      matching = "prefix";
      scroll-method = 0;
      disable-history = false;
      show-icons = false;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      display-calc = " ";
      display-emoji = " ";
    };

    theme = rofiTheme;
  };
}
