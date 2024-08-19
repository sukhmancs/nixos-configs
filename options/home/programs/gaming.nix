{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.home.gaming = {
    starcitizen.enable = mkEnableOption {
      default = false;
      description = "Enable Star Citizen";
    };

    runescape.enable = mkEnableOption {
      default = false;
      description = "Enable Runescape";
    };

    factorio.enable = mkEnableOption {
      default = false;
      description = "Enable Factorio";
    };

    lutris.enable = mkEnableOption {
      default = false;
      description = "Enable Lutris";
    };
  };
}