# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  config,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    silent = true;

    # faster, persistent implementation of use_nix and use_flake
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv.override {
        nix = config.nix.package;
      };
    };

    # enable loading direnv in nix-shell nix shell or nix develop
    loadInNixShell = true;

    direnvrcExtra = ''
      : ''${XDG_CACHE_HOME:=$HOME/.cache}
      declare -A direnv_layout_dirs

      # https://github.com/direnv/direnv/wiki/Customizing-cache-location#hashed-directories
      direnv_layout_dir() {
        echo "''${direnv_layout_dirs[$PWD]:=$(
          echo -n "$XDG_CACHE_HOME"/direnv/layouts/
          echo -n "$PWD" | ${pkgs.perl}/bin/shasum | cut -d ' ' -f 1
        )}"
      }
    '';
  };
}
