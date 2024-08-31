{
  stdenvNoCC,
  fetchFromGitHub,
  callPackages,
  lib,
  ...
}: let
  nv = (callPackages ./generated.nix {}).apple-fonts;
in
  stdenvNoCC.mkDerivation {
    inherit (nv) pname src version;
    installPhase = ''
      mkdir -p $out/share/fonts/apple/truetype
      install -m644 $src/'SF Pro Text'/*.otf $out/share/fonts/apple/truetype
      install -m644 $src/'SF Compact Text'/*.otf $out/share/fonts/apple/truetype
      install -m644 $src/'SF Mono'/*.otf $out/share/fonts/apple/truetype
      install -m644 $src/'SF Pro Display'/*.otf $out/share/fonts/apple/truetype
      install -m644 $src/'New York'/* $out/share/fonts/apple/truetype
    '';

    meta = {
      description = "Apple's San Francisco, New York, and SF Mono fonts";
      homepage = "https://github.com/fefelixa/macfonts";
      license = lib.licenses.mit;
      platforms = lib.platforms.all;
      maintainers = with lib.maintainers; [xi];
      mainProgram = "apple-fonts";
    };
  }
