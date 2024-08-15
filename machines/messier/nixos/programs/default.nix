{
  imports = [
    ./fonts.nix # default fonts (required for widgets)
    ./git.nix # version control
    ./misc.nix # miscellaneous programs
    ./river.nix # window manager
    ./sound.nix # pipewire sound server
    ./thunar.nix # file manager
    ./zsh.nix # shell
  ];
}
