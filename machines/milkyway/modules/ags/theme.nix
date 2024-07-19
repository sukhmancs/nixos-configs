{
  config,
  lib,
  ...
}: let
  # Function to read the YAML file as a string
  readYamlFile = file: builtins.readFile file;

  # Function to extract color values from the YAML content
  extractColors = yamlContent: let
    lines = lib.splitString "\n" yamlContent;
    getColor = name: lib.head (lib.filter (line: lib.hasPrefix (name + ":") line) lines);
    getValue = line: lib.trim (lib.substring (lib.strlen (lib.head (lib.splitString ":" line)) + 1) (lib.strlen line) line);
  in {
    scheme = getValue (getColor "scheme");
    author = getValue (getColor "author");
    base00 = getValue (getColor "base00");
    base01 = getValue (getColor "base01");
    base02 = getValue (getColor "base02");
    base03 = getValue (getColor "base03");
    base04 = getValue (getColor "base04");
    base05 = getValue (getColor "base05");
    base06 = getValue (getColor "base06");
    base07 = getValue (getColor "base07");
    base08 = getValue (getColor "base08");
    base09 = getValue (getColor "base09");
    base0A = getValue (getColor "base0A");
    base0B = getValue (getColor "base0B");
    base0C = getValue (getColor "base0C");
    base0D = getValue (getColor "base0D");
    base0E = getValue (getColor "base0E");
    base0F = getValue (getColor "base0F");
  };

  # Read and parse the colors from the YAML file
  colors = extractColors (readYamlFile ./catppuccin-mocha.yaml);

  # Generate SCSS content from the parsed colors
  scssContent = ''
    $scheme: "${colors.scheme}";
    $author: "${colors.author}";
    $base00: "${colors.base00}"; # base
    $base01: "${colors.base01}"; # mantle
    $base02: "${colors.base02}"; # surface0
    $base03: "${colors.base03}"; # surface1
    $base04: "${colors.base04}"; # surface2
    $base05: "${colors.base05}"; # text
    $base06: "${colors.base06}"; # rosewater
    $base07: "${colors.base07}"; # lavender
    $base08: "${colors.base08}"; # red
    $base09: "${colors.base09}"; # peach
    $base0A: "${colors.base0A}"; # yellow
    $base0B: "${colors.base0B}"; # green
    $base0C: "${colors.base0C}"; # teal
    $base0D: "${colors.base0D}"; # blue
    $base0E: "${colors.base0E}"; # mauve
    $base0F: "${colors.base0F}"; # flamingo
  '';
  variablesFile = builtins.toFile "variables.scss" scssContent;
in {
  modules.themes.colorscheme = {
    name = "catppuccin-mocha";
  };

  home.file.".config/ags/style/variables.scss".text = ''
    ${variablesFile}
  '';
}
