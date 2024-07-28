{
  lib,
  pkgs,
  ...
}: {
  # we don't need fontconfig on a server
  # since there are no fonts to be configured outside the console
  fonts.fontconfig.enable = lib.mkDefault true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
