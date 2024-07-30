{
  imports = [
    ./neovim # text editor

    ./fonts.nix # default fonts (required for widgets)
    ./git.nix # version control
    ./greetd.nix # display manager
    ./misc.nix # miscellaneous programs
    ./river.nix # window manager
    ./ssh.nix # openssh server and ssh client configuration
    ./thunar.nix # file manager
  ];
}