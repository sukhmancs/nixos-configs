{
  lib,
  stdenv,
  fetchurl,
  _7zz,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  makeWrapper,
  alsa-lib,
  at-spi2-atk,
  cups,
  nspr,
  nss,
  mesa, # for libgbm
  xorg,
  xdg-utils,
  libdrm,
  libnotify,
  libsecret,
  libuuid,
  gtk3,
  systemd,
}: let
  nv = (callPackages ./generated.nix {}).yesplaymusic;
in
  stdenvNoCC.mkDerivation {
    inherit (nv) pname src version;

    nativeBuildInputs = [
      autoPatchelfHook
      wrapGAppsHook3
      makeWrapper
    ];

    buildInputs = [
      alsa-lib
      at-spi2-atk
      cups
      nspr
      nss
      mesa
      xorg.libxshmfence
      xorg.libXScrnSaver
      xorg.libXtst
      xdg-utils
      libdrm
      libnotify
      libsecret
      libuuid
      gtk3
    ];

    runtimeDependencies = [
      (lib.getLib systemd)
    ];

    unpackPhase = ''
      ${dpkg}/bin/dpkg-deb -x $src .
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp -r opt $out/opt
      cp -r usr/share $out/share
      substituteInPlace $out/share/applications/yesplaymusic.desktop \
        --replace "/opt/YesPlayMusic/yesplaymusic" "$out/bin/yesplaymusic"
      makeWrapper $out/opt/YesPlayMusic/yesplaymusic $out/bin/yesplaymusic \
        --argv0 "yesplaymusic" \
        --add-flags "$out/opt/YesPlayMusic/resources/app.asar"

      runHook postInstall
    '';

    meta = {
      description = "Good-looking cloud music player for Linux";
      homepage = "https://github.com/qier222/YesPlayMusic/";
      license = lib.licenses.mit;
      platforms = lib.platforms.all;
      maintainers = with lib.maintainers; [xi];
      mainProgram = "yesplaymusic";
    };
  }
