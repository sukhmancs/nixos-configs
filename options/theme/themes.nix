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
  inherit (lib.strings) removePrefix hasPrefix isString;

  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };
  colorType = attrsOf (coercedTo str (removePrefix "#") hexColorType);

  cfg = config.modules.theme;
  slug = serializeTheme "${toString cfg.colorscheme.name}";

  getColorsFile = slug:
    if builtins.pathExists ../../themes/${slug}/${slug}.yaml
    then ../../themes/${slug}/${slug}.yaml
    else ../../themes/catppuccin-mocha/catppuccin-mocha.yaml;

  polarity = slug:
    if builtins.pathExists ../../themes/${slug}/polarity.txt
    then builtins.readFile ../../themes/${slug}/polarity.txt
    else builtins.readFile ../../themes/catppuccin-mocha/polarity.txt;

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
        The colorscheme.
      '';
    };

    # I don't really use this but it's here if i decided to use stylix
    polarity = mkOption {
      type = str;
      default = polarity slug;
      description = ''
        The polarity of the colorscheme.
      '';
    };
  };
}
