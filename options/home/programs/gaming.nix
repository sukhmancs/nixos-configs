{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.home.gaming = {
    # anyrun options is being used in exclusive/home-manager/programs/anyrun.nix
    starcitizen.enable = mkEnableOption {
      default = false;
      description = "Enable Star Citizen";
    };

    runescape.enable = mkEnableOption {
      default = false;
      description = "Enable Runescape";
    };
  };
}