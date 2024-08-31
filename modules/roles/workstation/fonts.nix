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
      defaultFonts = let
        # fonts that should be in each font family
        # if applicable
        fallbackFonts = [
          "Iosevka Nerd Font"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
      in
        mapAttrs (_: fonts: fonts ++ fallbackFonts) {
          serif = [
            "SF Pro Text"
            "Noto Serif"
            "Vazirmatn" # Persion
            "Microsoft YaHei" # Chinese
          ];
          sansSerif = [
            "SF Pro Text"
            "Lexend"
            "Vazirmatn" # Persian
            "Microsoft YaHei" # Chinese
          ];
          emoji = ["Noto Color Emoji"];
          monospace = [
            "Meslo LG M"
            "LiterationMono Nerd Font"
            "Source Code Pro Medium"
            "Source Han Mono"
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
      # defaults worth keeping
      freefont_ttf
      gyre-fonts
      liberation_ttf # for PDFs, Roman
      unifont

      # programming fonts
      sarasa-gothic
      (nerdfonts.override {fonts = ["LiberationMono" "FiraCode" "Iosevka" "JetBrainsMono" "NerdFontsSymbolsOnly"];})

      # emojis
      noto-fonts-color-emoji
      twemoji-color-font
      openmoji-color
      openmoji-black

      # other fonts
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
      lato
      lexend
      noto-fonts
      fira
    ];
  };
}
