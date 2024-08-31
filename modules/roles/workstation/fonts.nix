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
        # autohint = true;
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
              <string>Source Code Pro Medium</string>
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
              <family>Lexend</family>
              <family>Microsoft YaHei</family>
              <family>Vazirmatn</family>
              <family>Iosevka Nerd Font</family>
              <family>Noto Color Emoji</family>
            </prefer>
          </alias>
          <alias>
            <family>serif</family>
            <prefer>
              <family>Noto Serif</family>
              <family>Microsoft YaHei</family>
              <family>Vazirmatn</family>
              <family>Noto Color Emoji</family>
            </prefer>
          </alias>
          <alias>
            <family>monospace</family>
            <prefer>
              <family>Meslo LG M</family>
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
      #       "SF Pro Text"
      #       "Noto Serif"
      #       "Vazirmatn" # Persion
      #     ];
      #     sansSerif = [
      #       "SF Pro Text"
      #       "Lexend"
      #       "Vazirmatn" # Persian
      #     ];
      #     emoji = ["Noto Color Emoji"];
      #     monospace = [
      #       "Source Code Pro Medium"
      #       "Source Han Mono"
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

      # other fonts
      vazir-fonts # Persian font
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
