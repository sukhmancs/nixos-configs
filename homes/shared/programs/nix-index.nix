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
{inputs, pkgs, lib, ...}: {
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

    systemd.user.services.nix-index-database-sync = {
      Unit.Description = "fetch mic92/nix-index-database";
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe (
          pkgs.writeShellApplication {
            name = "fetch-nix-index-database";
            runtimeInputs = with pkgs; [
              wget
              coreutils
            ];
            text = ''
              mkdir -p ~/.cache/nix-index
              cd ~/.cache/nix-index
              name="index-${pkgs.stdenv.system}"
              wget -N "https://github.com/Mic92/nix-index-database/releases/latest/download/$name"
              ln -sf "$name" "files"
            '';
          }
        );
        Restart = "on-failure";
        RestartSec = "5m";
      };
    };
    systemd.user.timers.nix-index-database-sync = {
      Unit.Description = "Automatic github:mic92/nix-index-database fetching";
      Timer = {
        OnBootSec = "10m";
        OnUnitActiveSec = "24h";
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
