{
  callPackage,
  writeShellScriptBin,
  jdk17_headless,
  jetbrains,
}: let
  mainPkg = callPackage ./default.nix {};
in
  mainPkg.overrideAttrs (oa: {
    nativeBuildInputs = [
      jdk17_headless
      jetbrains.idea-community
    ];

    shellHook = ''
      ${jdk17_headless}/bin/java -version
    '';
  })
