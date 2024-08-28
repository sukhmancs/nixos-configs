{
  inputs',
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  hyprlandPkg = inputs'.hyprland.packages.hyprland;
in {
  # disables Nixpkgs Hyprland module to avoid conflicts
  disabledModules = ["programs/hyprland.nix"];

  config =
    mkIf
    ((config ? home-manager)
      && config.home-manager.users.xi.wayland.windowManager.hyprland.enable) {
      services.displayManager.sessionPackages = [hyprlandPkg];

      xdg.portal = {
        enable = true;
        configPackages = [hyprlandPkg];
        extraPortals = [
          (inputs'.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland.override {
            hyprland = hyprlandPkg;
          })
        ];
      };
    };
}
