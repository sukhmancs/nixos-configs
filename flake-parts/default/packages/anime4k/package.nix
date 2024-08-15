{
  lib,
  stdenvNoCC,
  callPackages,
  fetchzip,
  unzip,
}: let
  nv = (callPackages ./generated.nix {}).anime4k;
in
  stdenvNoCC.mkDerivation {
    inherit (nv) pname version src;

    buildInputs = [unzip];

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir $out
      cp *.glsl $out
    '';

    meta = with lib; {
      description = "A High-Quality Real Time Upscaler for Anime Video";
      homepage = "https://github.com/bloc97/Anime4K";
      license = licenses.mit;
      maintainers = with maintainers; [bloc97];
    };
  }
