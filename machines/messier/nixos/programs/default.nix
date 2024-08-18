{
  imports = [
    ./fonts.nix # default fonts (required for widgets)
    ./greetd.nix # login manager
    ./misc.nix # miscellaneous programs
    ./river.nix # window manager
    ./sound.nix # pipewire sound server
    ./thunar.nix # file manager
    ./zsh.nix # shell
  ];
}
