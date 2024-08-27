{
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  programs.yazi.theme.filetype = {
    rules = [
      # Images and videos
      {
        mime = "image/*";
        fg = "#${colors.base0C}";
      }
      {
        mime = "video/*";
        fg = "#${colors.base0F}";
      }
      {
        mime = "audio/*";
        fg = "#${colors.base0F}";
      }

      # Archives
      {
        mime = "application/zip";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/gzip";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/x-tar";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/x-bzip";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/x-bzip2";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/x-7z-compressed";
        fg = "#${colors.base09}";
      }
      {
        mime = "application/x-rar";
        fg = "#${colors.base09}";
      }

      # Fallback
      {
        name = "*";
        fg = "#${colors.base0A}";
      }
      {
        name = "*/";
        fg = "#${colors.base0E}";
      }
    ];
  };
}
