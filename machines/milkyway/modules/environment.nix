{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.home-manager.users.xi;
in {
  config = {
    environment.etc."greetd/environments".text = ''
      ${lib.optionalString (cfg.wayland.windowManager.hyprland.enable) "Hyprland"}
      zsh
    '';

    environment = {
      variables = {
        _JAVA_AWT_WM_NONEREPARENTING = "1";
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = "wayland,x11";
        ANKI_WAYLAND = "1";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
      };
    };
  };
}
