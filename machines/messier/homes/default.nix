{
  imports = [
    ./foot # terminal
    ./gtk # gtk theme
    ./nixvim
    ./river # window manager
    ./rofi # application launcher #TODO: fix rofi style
    ./waybar # status bar

    ./git.nix # git
    ./mako.nix # notification daemon
    ./schizofox.nix # firefox but hardened
    ./starship.nix # prompt
    ./swaylock.nix # screen locker
    ./swayidle.nix # screen idle
    ./zsh # shell
  ];
}
