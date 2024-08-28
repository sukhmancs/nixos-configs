{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib.strings) optionalString;
in {
  config = {
    home.packages = with pkgs; [
      ranger
    ];

    xdg.configFile."ranger/rc.conf".text = ''
      set preview_images true
      # Settings.
      set mouse_enabled true

      # Keys.
      map . set show_hidden!
      map DD console delete
      map <C-p> paste
      map <C-c> copy
      map <C-x> cut
      ${(optionalString config.programs.kitty.enable "set preview_images_method kitty")}
    '';
  };
}
