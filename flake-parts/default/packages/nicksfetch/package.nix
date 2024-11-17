{
  lib,
  stdenvNoCC,
  callPackages,
  fetchFromGitHub,
  bash,
  makeWrapper,
  pciutils,
  x11Support ? true,
  ueberzug,
}: let
  nv = (callPackages ./generated.nix {}).nicksfetch;
in
  stdenvNoCC.mkDerivation {
    inherit (nv) pname src;
    version = nv.date;

    patches = [./patches/0001-nicksfetch.patch];

    outputs = ["out" "man"];

    strictDeps = true;
    buildInputs = [bash];
    nativeBuildInputs = [makeWrapper];
    postPatch = ''
      patchShebangs --host neofetch
    '';

    postInstall = ''
      wrapProgram $out/bin/neofetch \
        --prefix PATH : ${lib.makeBinPath ([pciutils] ++ lib.optional x11Support ueberzug)}
    '';

    makeFlags = [
      "PREFIX=${placeholder "out"}"
      "SYSCONFDIR=${placeholder "out"}/etc"
    ];

    meta = {
      description = "A fast, highly customizable system info script";
      homepage = "https://github.com/dylanaraps/neofetch";
      license = lib.licenses.mit;
      platforms = lib.platforms.all;
      maintainers = with lib.maintainers; [xi];
      mainProgram = "neofetch";
    };
  }
