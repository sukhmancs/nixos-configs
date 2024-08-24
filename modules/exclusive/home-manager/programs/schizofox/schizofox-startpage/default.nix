{
  pkgs,
  osConfig,
  lib,
  stdenvNoCC,
}: let
  name = "schizofox-startpage";
  version = "2024-06-18-unstable";
  styleCss = pkgs.writeText "style.css" (import ./style.nix { inherit osConfig; });
in
  stdenvNoCC.mkDerivation {
    inherit name version;
    src = ./src;

    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -rv $src/* $out
      cp -v ${styleCss} $out/style.css
      runHook postInstall
    '';

    meta = {
      description = "Startpage for Schizofox";
    };
  }
