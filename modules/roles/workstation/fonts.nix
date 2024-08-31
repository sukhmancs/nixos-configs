{
  self',
  pkgs,
  lib,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
in {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;
      # cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };
      localConf = ''
        <?xml version='1.0'?>
        <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
        <fontconfig>
          <match target="pattern">
            <test qual="any" name="family">
              <string>sans-serif</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>SF Pro Text</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>serif</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>SF Pro Text</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>monospace</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>Meslo LG M</string>
            </edit>
          </match>
          <match>
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="append_last" binding="strong">
              <string>Noto Color Emoji</string>
            </edit>
          </match>
          <!-- Fallback fonts preference order -->
          <alias>
            <family>sans-serif</family>
            <prefer>
              <family>Noto Color Emoji</family>
              <family>Microsoft YaHei</family>
              <family>Vazirmatn</family>
            </prefer>
          </alias>
          <alias>
            <family>serif</family>
            <prefer>
              <family>Noto Color Emoji</family>
              <family>Microsoft YaHei</family>
              <family>Vazirmatn</family>
            </prefer>
          </alias>
          <alias>
            <family>monospace</family>
            <prefer>
              <family>LiterationMono Nerd Font</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
      # defaultFonts = let
      #   # fonts that should be in each font family
      #   # if applicable
      #   common = [
      #     "Iosevka Nerd Font"
      #     "Symbols Nerd Font"
      #     "Noto Color Emoji"
      #   ];
      # in
      #   mapAttrs (_: fonts: fonts ++ common) {
      #     serif = [
      #       "Noto Serif"
      #       "Vazirmatn" # Persion
      #     ];
      #     sansSerif = [
      #       "Lexend"
      #       "Vazirmatn" # Persian
      #       "Noto Sans CJK HK" # Hong Kong
      #       "Noto Sans CJK JP" # Japan
      #       "Noto Sans CJK KR" # Korea
      #       "Noto Sans CJK SC" # Simplified Chinese
      #       "Noto Sans CJK TC" # Traditional Chinese
      #     ];
      #     emoji = ["Noto Color Emoji"];
      #     monospace = [
      #       "Source Code Pro Medium"
      #       "Source Han Mono"
      #       "Noto Sans Mono CJK HK" # Hong Kong
      #       "Noto Sans Mono CJK JP" # Japan
      #       "Noto Sans Mono CJK KR" # Korea
      #       "Noto Sans Mono CJK SC" # Simplified Chinese
      #       "Noto Sans Mono CJK TC" # Traditional Chinese
      #     ];
      #   };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

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

      # Persian Font
      vazir-fonts

      # Asian language fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      roboto # Google font
      roboto-mono # Google font monospace
      siji # bitmap font
      (self'.packages.apple-fonts) # Apple fonts (SF Pro Text, New York)
      cantarell-fonts # GNOME font
      cascadia-code # Windows Terminal font
      dejavu_fonts # Typeface family based on the Bitstream Vera fonts
      source-han-mono # Open source Pan-CJK monospaced typeface
      source-han-sans # Open source Pan-CJK sans-serif typeface
      ubuntu-sans # Ubuntu font family
      vistafonts-chs # TrueType fonts from Microsoft Windows Vista For Traditional Chinese (Microsoft JhengHei)
      meslo-lg # Customized version of Apple’s Menlo-Regular font
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
      noto-fonts
      fira
    ];
  };
}
