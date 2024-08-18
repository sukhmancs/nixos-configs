{
  pkgs,
  lib,
  stdenvNoCC,
}: let
  name = "schizofox-startpage";
  version = "2024-06-18-unstable";
  styleCss = pkgs.writeText "style.css" (builtins.readFile ./style.css);
in
  stdenvNoCC.mkDerivation {
    inherit name version;
    src = ./src;

    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -rv $src/* $out
      cp -v $styleCss $out
      runHook postInstall
    '';

    meta = {
      description = "Startpage for Schizofox";
    };
  }
