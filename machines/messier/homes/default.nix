{
  imports = [
    ./foot # terminal
    ./gtk # gtk theme
    ./river # window manager
    ./rofi # application launcher #TODO: fix rofi style
    ./waybar # status bar

    ./alacritty.nix # terminal (just a backup terminal)
    ./mako.nix # notification daemon
    ./starship.nix # prompt
    ./swaylock.nix # screen locker
    ./swayidle.nix # screen idle
    ./zsh # shell
  ];
}
