{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) attrValues mkDefault;
in {
  console = {
    enable = mkDefault true;
    earlySetup = true;
    keyMap = "dvorak";

    font = "ter-powerline-v18n";
    packages = attrValues {inherit (pkgs) terminus_font powerline-fonts;};
  };
}
