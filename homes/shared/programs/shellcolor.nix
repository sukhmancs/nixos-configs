{config, osConfig, lib, ...}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in {
  programs.shellcolor = {
    enable = true;
    settings = {
      base00 = "${colors.base00}";
      base05 = "${colors.base05}";
      base03 = "${colors.base03}";
      base07 = "${colors.base07}";
      base08 = "${colors.base08}";
      base0B = "${colors.base0B}";
      base0A = "${colors.base0A}";
      base0D = "${colors.base0D}";
      base0E = "${colors.base0E}";
      base0C = "${colors.base0C}";
      base09 = "${colors.base09}";
      base0F = "${colors.base0F}";
      base01 = "${colors.base01}";
      base04 = "${colors.base04}";
      base02 = "${colors.base02}";
      base06 = "${colors.base06}";
    };
  };
}