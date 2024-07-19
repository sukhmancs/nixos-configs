# theme.nix
{
  osConfig,
  pkgs,
  ...
}: let
  parseYaml = file:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "converted-yaml.json" {} ''
          ${pkgs.yj}/bin/yj < "${file}" > $out
        ''
      )
    );

  colors = parseYaml osConfig.modules.themes.colorsFile;

  # Generate SCSS content from the parsed colors
  scssContent = ''
    $scheme: "${colors.scheme}";
    $author: "${colors.author}";
    $base00: #${colors.base00}; // base
    $base01: #${colors.base01}; // mantle
    $base02: "${colors.base02}"; // surface0
    $base03: "${colors.base03}"; // surface1
    $base04: "${colors.base04}"; // surface2
    $base05: "${colors.base05}"; // text
    $base06: "${colors.base06}"; // rosewater
    $base07: "${colors.base07}"; // lavender
    $base08: "${colors.base08}"; // red
    $base09: "${colors.base09}"; // peach
    $base0A: "${colors.base0A}"; // yellow
    $base0B: "${colors.base0B}"; // green
    $base0C: "${colors.base0C}"; // teal
    $base0D: "${colors.base0D}"; // blue
    $base0E: "${colors.base0E}"; // mauve
    $base0F: "${colors.base0F}"; // flamingo
  '';

  variablesFile = builtins.toFile "variables.scss" scssContent;
in {
  # Use home-manager to manage the variables.scss file directly
  home.file.".config/ags/style/variables.scss".text = builtins.readFile variablesFile;
}
