{
  osConfig,
  lib,
  inputs',
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  prg = modules.home.exclusive.packages;
in {
  config = mkIf prg.enable {
    home.packages = with pkgs; [
      # Whitehat tools
      binwalk
      binutils
      diffoscopeMinimal
      nmap
      nmapsi4

      # tools that help with media operations/management
      ffmpeg-full
      yt-dlp
      mpc
      playerctl
      pavucontrol
      pulsemixer
      imv
      cantata
      easytag
      kid3
      musikcube

      # Other tools
      libnotify
      imagemagick
      bitwarden-cli
      trash-cli
      slides
      brightnessctl
      pamixer
      nix-tree
      tgpt
      ani-cli

      # Recording
      grim
      wlogout
      swappy
      slurp
      grim
      wl-clipboard
      pngquant
      wf-recorder
      (pkgs.writeShellApplication {
        name = "ocr";
        runtimeInputs = with pkgs; [tesseract grim slurp coreutils];
        text = ''
          echo "Generating a random ID..."
          id=$(tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 6 | head -n 1 || true)
          echo "Image ID: $id"

          echo "Taking screenshot..."
          grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr-"$id".png

          echo "Running OCR..."
          tesseract /tmp/ocr-"$id".png - | wl-copy
          echo -en "File saved to /tmp/ocr-'$id'.png\n"


          echo "Sending notification..."
          notify-send "OCR " "Text copied!"

          echo "Cleaning up..."
          rm /tmp/ocr-"$id".png -vf

        '';
      })
    ];
  };
}
