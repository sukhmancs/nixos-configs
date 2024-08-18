{ osConfig, pkgs, lib, ... }:
let
  inherit (osConfig) modules;
  inherit (lib) mkIf;
  gam = modules.home.gaming;

  # Add PULSE_LATENCY_MSEC to .desktop file
  pulse_latency = 100;
  runescape = pkgs.runescape.overrideAttrs (oa: {
    nativeBuildInputs = (oa.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
    buildCommand =
      (oa.buildCommand or "")
      +
      /*
      bash
      */
      ''
        wrapProgram "$out/bin/RuneScape" \
          --set PULSE_LATENCY_MSEC ${toString pulse_latency} \
          --run 'echo $PULSE_LATENCY_MSEC'
      '';
  });
in
{
  config = mkIf gam.runescape.enable {
    home.packages = [
      runescape
      # TODO: Broken
      # pkgs.runelite
    ];
  };
}
