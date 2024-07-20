{
  inputs',
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
  inherit (modules.themes) colorsFile;

  parseYaml = file:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "converted-yaml.json" {} ''
          ${pkgs.yj}/bin/yj < "${file}" > $out
        ''
      )
    );
  # Parse the yaml colors file
  colors = parseYaml osConfig.modules.themes.colorsFile;

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
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
