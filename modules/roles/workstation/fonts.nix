{
  self',
  pkgs,
  lib,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
in {
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      # cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };
      defaultFonts = {
        serif = [
          "SF Pro Text"
          "Noto Serif"
          "Vazirmatn" # Persion
          "Microsoft YaHei" # Chinese
          "Iosevka Nerd Font"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "SF Pro Text"
          "Lexend"
          "Vazirmatn" # Persian
          "Microsoft YaHei" # Chinese
          "Iosevka Nerd Font"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
        emoji = [
          "Noto Color Emoji"
          "Iosevka Nerd Font"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Meslo LG M"
          "LiterationMono Nerd Font"
          "Source Code Pro Medium"
          "Source Han Mono"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    enableDefaultPackages = false;

    # font packages that should be installed
    packages = with pkgs; [
      freefont_ttf # Free font
      gyre-fonts # TeX Gyre fonts
      liberation_ttf # Liberation fonts
      unifont # Unicode font
      sarasa-gothic # Japanese font
      (nerdfonts.override {fonts = ["LiberationMono" "FiraCode" "Iosevka" "JetBrainsMono" "NerdFontsSymbolsOnly"];})
      noto-fonts-color-emoji # Google emoji
      twemoji-color-font # Twitter emoji
      openmoji-color # colorful version of openmoji
      openmoji-black # black and white version of openmoji
      vazir-fonts # Persian font
      roboto # Google font
      roboto-mono # Google font monospace
      siji # bitmap font
      (self'.packages.apple-fonts) # Apple fonts (SF Pro Text, New York, SF Mono, SF Pro Display, SF Compact Text)
      cantarell-fonts # GNOME font
      cascadia-code # Windows Terminal font
      dejavu_fonts # Typeface family based on the Bitstream Vera fonts
      source-han-mono # Open source Pan-CJK monospaced typeface
      source-han-sans # Open source Pan-CJK sans-serif typeface
      ubuntu-sans # Ubuntu font family
      vistafonts-chs # TrueType fonts from Microsoft Windows Vista For Traditional Chinese (Microsoft JhengHei)
      meslo-lg # Customized version of Apple’s Menlo-Regular font
      corefonts # MS fonts
      b612 # high legibility
      material-icons # used in widgets and such
      material-design-icons
      work-sans # Google font
      comic-neue # Comic Sans alternative
      source-sans # Adobe font
      inter # Google font
      lato # Google font
      lexend # Google font
      noto-fonts # Google font
      fira # Mozilla font
      fira-code # Mozilla font
    ];
  };
}
