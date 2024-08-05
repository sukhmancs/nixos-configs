{pkgs, ...}: {
  programs = {
    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;

    # show network usage
    bandwhich.enable = true;

    # registry for linux, thanks to gnome
    dconf.enable = true;

    # network inspection utility
    wireshark.enable = true;

    # gnome's keyring manager
    seahorse.enable = true;

    # networkmanager tray uility
    nm-applet.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      qbittorrent
      kdePackages.dolphin
      calibre
      bitwarden-desktop
      gifsicle # optimize gifs (i.e. decrease the size of gif etc.)
      (symlinkJoin {
        name = "Obsidian";
        paths = with pkgs; [
          obsidian
          pandoc
        ];
      })
      # Convert mkv to gif and then optimize this gif to be of smaller size
    # run it like this: convert-to-gif input.mkv output.gif
    (writeShellScriptBin "convert-to-gif" ''
      ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos" -c:v pam -f image2pipe - | convert -delay 10 -loop 0 - gif:- | gifsicle --optimize=3 --colors 256 > "$2"
    '')
    ];
  };
}
