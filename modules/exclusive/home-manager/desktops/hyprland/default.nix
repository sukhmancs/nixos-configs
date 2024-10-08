{
  inputs',
  inputs,
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) hasSuffix;
  inherit (osConfig) modules;

  inherit (import ./packages {inherit inputs' pkgs;}) grimblast hyprshot dbus-hyprland-env hyprpicker;
in {
  imports = filter (hasSuffix ".nix") (
    map toString (filter (p: p != ./default.nix) (listFilesRecursive ./config))
  );
  config = mkIf config.wayland.windowManager.hyprland.enable {
    home.packages = [
      hyprshot
      grimblast
      hyprpicker
      dbus-hyprland-env
    ];

    wayland.windowManager.hyprland = {
      package = inputs'.hyprland.packages.hyprland;
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.system}.hyprexpo
      ];
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
