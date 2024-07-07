{
  imports = [
    ./bash.nix
    ./console.nix
    ./crash.nix
    ./direnv.nix
    ./journald.nix
    ./nano.nix
  ];

  programs = {
    # less pager
    less.enable = true;

    # home-manager is quirky as ever, and wants this to be set in system config
    # instead of just home-manager
    zsh.enable = true;

    # type "fuck" to fix the last command that made you go "fuck"
    thefuck.enable = true;
  };
}
