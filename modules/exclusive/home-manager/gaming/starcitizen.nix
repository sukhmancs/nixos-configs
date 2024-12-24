{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (lib) mkIf;
  gam = modules.home.gaming;
in {
  config = mkIf gam.starcitizen.enable {
    home.packages = [inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen];
  };
}
