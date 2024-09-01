{
  lib,
  stdenvNoCC,
  callPackages,
  fetchzip,
  unzip,
}: let
  nv = (callPackages ./generated.nix {}).stats;
in
  stdenvNoCC.mkDerivation {
    inherit (nv) pname version src;

    buildInputs = [unzip];

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir $out
      cp -r * $out
    '';

    meta = with lib; {
      description = "stats - spicetify custom apps";
      homepage = "https://github.com/harbassan/spicetify-apps";
      license = licenses.mit;
      maintainers = with maintainers; [harbassan xi];
      mainProgram = "stats";
    };
  }
