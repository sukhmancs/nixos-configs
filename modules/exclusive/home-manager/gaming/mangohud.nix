{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf config.programs.mangohud.enable {
    programs.mangohud = {
      settings = {
        fps_limit = "60,0";
        vsync = 1;
        cpu_stats = true;
        cpu_temp = true;
        gpu_stats = true;
        gpu_temp = true;
        vulkan_driver = false;
        fps = true;
        frametime = true;
        frame_timing = true;
        enableSessionWide = true;
        font_size = 24;
        position = "top-left";
        engine_version = true;
        wine = true;
        no_display = true;
        background_alpha = "0.5";
        toggle_hud = "Shift_R+F12";
        toggle_fps_limit = "Shift_R+F1";
      };
    };

    home.packages = with pkgs; [
      legendary-gl # epic games launcher
      mangohud # fps counter & vulkan overlay
      lutris # alternative game launcher

      # emulators
      # dolphin-emu # general console

      # runtime
      dotnet-runtime_6 # for running terraria manually, from binary
      mono # general dotnet apps
      winetricks # wine helper utility
    ];
  };
}
