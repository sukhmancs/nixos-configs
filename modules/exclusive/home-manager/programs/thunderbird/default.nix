{
  osConfig,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
in {
  config = mkIf config.programs.thunderbird.enable {
    home.packages = with pkgs; [birdtray thunderbird];

    programs.thunderbird = {
      profiles."xi" = {
        isDefault = true;
        userChrome = "";
        userContent = "";
        withExternalGnupg = true;
      };
    };
  };
}
