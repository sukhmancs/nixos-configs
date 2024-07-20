# theme.nix
{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  # This will first convert the yaml file to json and then convert the json to a nix attrset
  parseYaml = file:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "converted-yaml.json" {} ''
          ${pkgs.yj}/bin/yj < "${file}" > $out
        ''
      )
    );
  # Parse the yaml colors file
  # colors = parseYaml osConfig.modules.themes.colorsFile;

  # Generate SCSS content from the parsed colors
  scssContent = ''
    $scheme: "${colors.scheme}";
    $author: "${colors.author}";
    $base00: #${colors.base00};
    $base01: #${colors.base01};
    $base02: #${colors.base02};
    $base03: #${colors.base03};
    $base04: #${colors.base04};
    $base05: #${colors.base05};
    $base06: #${colors.base06};
    $base07: #${colors.base07};
    $base08: #${colors.base08};
    $base09: #${colors.base09};
    $base0A: #${colors.base0A};
    $base0B: #${colors.base0B};
    $base0C: #${colors.base0C};
    $base0D: #${colors.base0D};
    $base0E: #${colors.base0E};
    $base0F: #${colors.base0F};
  '';
in
  builtins.toFile "variables.scss" scssContent
# Use home-manager to manage the variables.scss file directly
# home.file.".config/ags/style/variables.scss".text = builtins.readFile variablesFile;

