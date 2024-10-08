# Colorscheme
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib) serializeTheme;
  inherit (lib.types) str nullOr enum mkOptionType path attrsOf coercedTo;
  inherit (lib.strings) removePrefix hasPrefix isString trim;

  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };
  colorType = attrsOf (coercedTo str (removePrefix "#") hexColorType);

  cfg = config.modules.themes;
  slug = serializeTheme "${toString cfg.colorscheme.name}";

  # Get the colors file
  getColorsFile = slug:
    if builtins.pathExists ../../themes/${slug}/${slug}.yaml
    then ../../themes/${slug}/${slug}.yaml
    else ../../themes/catppuccin-mocha/catppuccin-mocha.yaml;

  parseYaml = file:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "converted-yaml.json" {} ''
          ${pkgs.yj}/bin/yj < "${file}" > $out
        ''
      )
    );
  # Parse the yaml colors file
  colors = parseYaml config.modules.themes.colorsFile;

  # Get the polarity of the colorscheme
  # Expected output: "dark" or "light"
  polarity = slug:
    if builtins.pathExists ../../themes/${slug}/polarity.txt
    then trim (builtins.readFile ../../themes/${slug}/polarity.txt)
    else trim (builtins.readFile ../../themes/catppuccin-mocha/polarity.txt);

  # Get the wallpaper image
  # Expected output: path to the wallpaper image
  wallpaperUrl = if builtins.pathExists ../../themes/${slug}/backgroundurl.txt
    then trim (builtins.readFile ../../themes/${slug}/backgroundurl.txt)
    else trim (builtins.readFile ../../themes/catppuccin-mocha/backgroundurl.txt);

  wallpaperSha256 = if builtins.pathExists ../../themes/${slug}/backgroundsha256.txt
    then trim (builtins.readFile ../../themes/${slug}/backgroundsha256.txt)
    else trim (builtins.readFile ../../themes/catppuccin-mocha/backgroundsha256.txt);

  wallpaperImage = builtins.fetchurl {
    url = wallpaperUrl;
    sha256 = wallpaperSha256;
  };
in {
  options.modules.themes = {
    # choose a colorscheme
    colorscheme = {
      # "Name Of The Scheme"
      name = mkOption {
        type = str;
        description = "The colorscheme that should be used globally to theme your system.";
        default = "catppuccin-mocha";
      };
    };

    colorsFile = mkOption {
      type = path;
      default = getColorsFile slug;
      description = ''
        The path to the colorscheme file.
      '';
    };

    colors = mkOption {
      type = colorType;
      default = colors;
      description = ''
        scheme = "Catppuccin Mocha";
        author = "https://github.com/catppuccin/catppuccin";
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
      '';
    };

    # light or dark
    polarity = mkOption {
      type = str;
      default = polarity slug; # "dark" or "light"
      description = ''
        The polarity of the colorscheme. Expected values are "dark" or "light".
      '';
    };

    wallpaper = mkOption {
      type = path;
      default = wallpaperImage;
      description = ''
        The path to the wallpaper image file. Expected values are a path to an image file.
      '';
    };
  };
}
