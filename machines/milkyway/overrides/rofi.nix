#
# Override - rofi with wayland plugins
#
{
  pkgs,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkForce;
in {
  home-manager.users.xi = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland.override {
        plugins = [
          pkgs.rofi-rbw-wayland
        ];
      };
      font = mkForce "Iosevka Nerd Font 14";
      extraConfig = mkForce {
        modi = "drun,filebrowser";
        drun-display-format = " {name} ";
        sidebar-mode = true;
        matching = "prefix";
        scroll-method = 0;
        disable-history = false;
        show-icons = true;

        display-drun = " Run";
        display-run = " Run";
        display-filebrowser = " Files";
      };
    };
  };
}
