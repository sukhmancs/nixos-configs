{ config, lib, pkgs, inputs, ... }:
with lib;
let
  colorType =
    types.addCheck types.str (x: !isNull (builtins.match "[0-9a-fA-F]{6}" x));
  color = mkOption { type = colorType; };

  font = {
    family = mkOption { type = types.str; };
    size = mkOption { type = types.int; };
  };

  fromYAML = yaml:
    builtins.fromJSON (builtins.readFile (pkgs.stdenv.mkDerivation {
      name = "fromYAML";
      phases = [ "buildPhase" ];
      buildPhase = "echo '${yaml}' | ${pkgs.yaml2json}/bin/yaml2json > $out";
    }));
in {
  options = {
    themes = {
      colors = builtins.listToAttrs (map (name: {
        inherit name;
        value = color;
      }) [
        "base00"
        "base01"
        "base02"
        "base03"
        "base04"
        "base05"
        "base06"
        "base07"
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
      ]);
      fonts = {
        main = font;
        serif = font;
        mono = font;
      };
    };
  };
  config = {
    themes.colors = {
      base00 = {
        name = "base00";
        value = "000000";
      };
      base01 = {
        name = "base01";
        value = "1a1a1a";
      };
      base02 = {
        name = "base02";
        value = "333333";
      };
      base03 = {
        name = "base03";
        value = "808080";
      };
      base04 = {
        name = "base04";
        value = "cccccc";
      };
      base05 = {
        name = "base05";
        value = "ffffff";
      };
      base06 = {
        name = "base06";
        value = "e6e6e6";
      };
      base07 = {
        name = "base07";
        value = "e6e6e6";
      };
      base08 = {
        name = "base08";
        value = "bf4040";
      };
      base09 = {
        name = "base09";
        value = "bf8040";
      };
      base0A = {
        name = "base0A";
        value = "bfbf40";
      };
      base0B = {
        name = "base0B";
        value = "80bf40";
      };
      base0C = {
        name = "base0C";
        value = "40bfbf";
      };
      base0D = {
        name = "base0D";
        value = "407fbf";
      };
      base0E = {
        name = "base0E";
        value = "7f40bf";
      };
      base0F = {
        name = "base0F";
        value = "bf40bf";
      };
    };
  };
}