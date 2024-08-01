{
  imports = [
    # ./neovim # text editor

    ./fonts.nix # default fonts (required for widgets)
    # ./firefox.nix # hardened firefox
    ./git.nix # version control
    # ./greetd.nix # display manager
    ./misc.nix # miscellaneous programs
    ./river.nix # window manager
    # ./ssh.nix # openssh server and ssh client configuration
    ./sound.nix # pipewire sound server
    ./thunar.nix # file manager
    ./zsh.nix # shell
  ];
}
