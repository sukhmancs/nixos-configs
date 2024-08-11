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
        modi = "drun,run,filebrowser,window";
        drun-display-format = " {name} ";
        window-format = "{w}   {c}   {t}";
        sidebar-mode = true;
        matching = "prefix";
        scroll-method = 0;
        disable-history = false;
        show-icons = true;

        display-drun = "";
        display-run = "";
        display-filebrowser = "";
        display-window = "";
      };
    };
  };
}
