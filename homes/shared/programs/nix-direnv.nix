#
# Direnv - load/unload environment variables based on the current directory
#
# Direnv is an environment switcher for the shell. It knows how to hook into
# bash, zsh, tcsh, fish shell and elvish to load or unload environment variables
# depending on the current directory. This allows project-specific environment
# variables.
{pkgs, ...}: {
  # Set the log format to an empty string to avoid direnv from polluting the
  # shell output with log messages.
  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs.direnv = {
    enable = true;
    # nix-direnv enables the use of use_nix and use_flake in .envrc files.
    nix-direnv.enable = true;
    # stdlib = ''
    #   : ''${XDG_CACHE_HOME:=$HOME/.cache}
    #   declare -A direnv_layout_dirs
    #   direnv_layout_dir() {
    #       echo "''${direnv_layout_dirs[$PWD]:=$(
    #           echo -n "$XDG_CACHE_HOME"/direnv/layouts/
    #           echo -n "$PWD" | ${pkgs.perl}/bin/shasum| cut -d ' ' -f 1
    #       )}"
    #   }
    # '';

    # we should probably do this ourselves
    enableZshIntegration = true;
  };
}
