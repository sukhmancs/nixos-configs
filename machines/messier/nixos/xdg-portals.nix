{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce;
in {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common = let
        portal = "gtk";
      in {
        default = ["gtk"];
      };
    };

    # xdg-desktop-wlr (this section) is no longer needed, xdg-desktop-portal-hyprland
    # will (and should) override this one
    # however in case I run a different compositor on a Wayland host, it can be enabled
    wlr = {
      enable = mkForce true;
      settings = {
        screencast = {
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };
}
