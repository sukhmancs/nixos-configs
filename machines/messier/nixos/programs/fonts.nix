{
  lib,
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = lib.mkDefault true;
  fonts.packages = with pkgs; [
    # desktop fonts
    corefonts # MS fonts
    b612 # high legibility
    material-icons # used in widgets and such
    material-design-icons
    work-sans
    comic-neue
    source-sans
    inter
    lato
    lexend
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans

    # emojis
    noto-fonts-color-emoji
    twemoji-color-font
    openmoji-color
    openmoji-black
  ];
}
