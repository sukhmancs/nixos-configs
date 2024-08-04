###
### Nix-index provides a "command-not-found" script.
###
### Run following command to download the database
### without any database command-not-found will not work:
###
###   $ nix run github:nix-community/nix-index#nix-index
###
### Example output:
### $ blender
###  The program 'blender' is currently not installed. You can install it
###  by typing:
###    nix-env -iA nixpkgs.blender.out
###
###  Or run it once with:
###    nix-shell -p blender.out --run ...
###
{inputs, ...}: {
  # imports = [inputs.nix-index-db.hmModules.nix-index];

  config = {
    home.sessionVariables = {
      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";
    };

    programs = {
      # nix-index-database.comma.enable = true;

      # `command-not-found` relies on nix-channel.
      # Enable and use `nix-index` instead.
      command-not-found.enable = false;
      nix-index = {
        enable = true;
        enableZshIntegration = true;
        # link nix-inde database to ~/.cache/nix-index
        # symlinkToCacheHome = true;
      };
    };
  };
}
