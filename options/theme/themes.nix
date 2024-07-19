# Colorscheme
{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib) serializeTheme;
  inherit (lib.types) str nullOr enum mkOptionType;

  cfg = config.modules.theme;
  slug = serializeTheme "${toString cfg.colorscheme.name}";

  getColorsFile = slug:
    if builtins.pathExists ../../themes/${slug}/${slug}.yaml
    then ../../themes/${slug}/${slug}.yaml
    else throw "The following colorscheme was imported but not found: ${slug}";

  polarity = slug:
    if builtins.pathExists ../../themes/${slug}/polarity.txt
    then builtins.readFile ../../themes/${slug}/polarity.txt
    else throw "The following colorscheme was imported but not found: ${slug}";
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
      type = str;
      default = getColorsFile config.modules.themes.colorscheme.name;
      description = ''
        The path to the colorscheme file.
      '';
    };

    # I don't really use this but it's here if i decided to use stylix
    polarity = mkOption {
      type = str;
      default = polarity config.modules.themes.colorscheme.name;
      description = ''
        The polarity of the colorscheme.
      '';
    };
  };
}
