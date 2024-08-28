{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  cfg = config.home-manager.users.xi;
in {
  config =
    mkIf
    ((config ? home-manager)
      && (config.home-manager.users.xi.wayland.windowManager.hyprland.enable
        || config.home-manager.users.xi.wayland.windowManager.sway.enable)) {
      xdg.portal = {
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];

        config = {
          common = let
            portal =
              if cfg.wayland.windowManager.hyprland.enable
              then "hyprland"
              else if cfg.wayland.windowManager.sway.enable
              then "wlr"
              else "gtk"; # FIXME: does this actually implement what we need?
          in {
            default = ["gtk"];

            # for flameshot to work
            # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
            "org.freedesktop.impl.portal.Screencast" = ["${portal}"];
            "org.freedesktop.impl.portal.Screenshot" = ["${portal}"];
          };
        };

        # xdg-desktop-wlr (this section) is no longer needed, xdg-desktop-portal-hyprland
        # will (and should) override this one
        # however in case I run a different compositor on a Wayland host, it can be enabled
        wlr = {
          enable = mkForce (cfg.wayland.windowManager.sway.enable);
          settings = {
            screencast = {
              max_fps = 30;
              chooser_type = "simple";
              chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
            };
          };
        };
      };
    };
}
