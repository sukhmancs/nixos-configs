# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  inputs,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) map;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;

  inherit (osConfig) modules;
  prg = modules.home.programs;

  monitors = modules.device.monitors;

  hyprpaper = inputs.hyprpaper.packages.${pkgs.stdenv.system}.default;
  wallpkgs = inputs.wallpkgs.packages.${pkgs.stdenv.system};
in {
  config = mkIf prg.hyprpaper.enable {
    xdg.configFile."hypr/assets" = {
      source = ./assets;
    };

    systemd.user.services.hyprpaper = lib.mkHyprlandService {
      Unit.Description = "Hyprland wallpaper daemon";
      Service = {
        Type = "simple";
        ExecStart = "${getExe hyprpaper}";
        Restart = "on-failure";
      };
    };

    xdg.configFile."hypr/hyprpaper.conf" = {
      text = let
        #wallpaper = "${wallpkgs.catppuccin}/share/wallpapers/catppuccin/01.png";
        wallpaper = "$HOME/.config/hypr/assets/wall1.jpg";
      in ''
        preload=${wallpaper}
        ${concatStringsSep "\n" (map (monitor: ''wallpaper=${monitor},${wallpaper}'') monitors)}
        ipc=off
      '';
    };
  };
}
