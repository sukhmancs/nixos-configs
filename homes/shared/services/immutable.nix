{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = filterAttrs (n: f: f.enable) config.home.immutableFile;

  homeDirectory = config.home.homeDirectory;
  # fileType =
  #   (import lib/file-type.nix {
  #     inherit homeDirectory lib pkgs;
  #   })
  #   .fileType;
  # sourceStorePath = file: let
  #   sourcePath = toString file.source;
  #   sourceName = config.lib.strings.storeFileName (baseNameOf sourcePath);
  # if builtins.hasContext sourcePath
  # then file.source
  # else
  #   builtins.path {
  #     path = file.source;
  #     name = sourceName;
  #   };
in {
  options = {
    home.immutableFile = mkOption {
      description = "Attribute set of files to link into the user home.";
      default = {};
      type = fileType "home.file" "{env}`HOME`" homeDirectory;
    };
  };

  config = {
    # This activation script will
    #
    # 1. Remove files from the old generation that are not in the new
    #    generation.
    #
    # 2. Switch over the Home Manager gcroot and current profile
    #    links.
    #
    # 3. Symlink files from the new generation into $HOME.
    #
    # This order is needed to ensure that we always know which links
    # belong to which generation. Specifically, if we're moving from
    # generation A to generation B having sets of home file links FA
    # and FB, respectively then cleaning before linking produces state
    # transitions similar to
    #
    #      FA   →   FA ∩ FB   →   (FA ∩ FB) ∪ FB = FB
    #
    # and a failure during the intermediate state FA ∩ FB will not
    # result in lost links because this set of links are in both the
    # source and target generation.
    home.activation = hm.dag.entryAfter ["writeBoundary"] (
      let
        link = pkgs.writeShellScript "link" ''
          ${config.lib.bash.initHomeManagerLib}

          newGenFiles="$1"
          shift
          for sourcePath in "$@" ; do
            relativePath="''${sourcePath#$newGenFiles/}"
            targetPath="$HOME/$relativePath"
            if [[ -e "$targetPath" && ! -L "$targetPath" && -n "$HOME_MANAGER_BACKUP_EXT" ]] ; then
              # The target exists, back it up
              backup="$targetPath.$HOME_MANAGER_BACKUP_EXT"
              run mv $VERBOSE_ARG "$targetPath" "$backup" || errorEcho "Moving '$targetPath' failed!"
            fi

            if [[ -e "$targetPath" && ! -L "$targetPath" ]] && cmp -s "$sourcePath" "$targetPath" ; then
              # The target exists but is identical – don't do anything.
              verboseEcho "Skipping '$targetPath' as it is identical to '$sourcePath'"
            else
              # Place that symlink, --force
              # This can still fail if the target is a directory, in which case we bail out.
              run mkdir -p $VERBOSE_ARG "$(dirname "$targetPath")"
              run ln -Tsf $VERBOSE_ARG "$sourcePath" "$targetPath" || exit 1

              # Make the symlink immutable
              run chattr +i "$targetPath" || errorEcho "Making '$targetPath' immutable failed!"
            fi
          done
        '';

        cleanup = pkgs.writeShellScript "cleanup" ''
          ${config.lib.bash.initHomeManagerLib}

          # A symbolic link whose target path matches this pattern will be
          # considered part of a Home Manager generation.
          homeFilePattern="$(readlink -e ${escapeShellArg builtins.storeDir})/*-home-manager-files/*"

          newGenFiles="$1"
          shift 1
          for relativePath in "$@" ; do
            targetPath="$HOME/$relativePath"
            if [[ -e "$newGenFiles/$relativePath" ]] ; then
              verboseEcho "Checking $targetPath: exists"
            elif [[ ! "$(readlink "$targetPath")" == $homeFilePattern ]] ; then
              warnEcho "Path '$targetPath' does not link into a Home Manager generation. Skipping delete."
            else
              verboseEcho "Checking $targetPath: gone (deleting)"
              run rm $VERBOSE_ARG "$targetPath"

              # Recursively delete empty parent directories.
              targetDir="$(dirname "$relativePath")"
              if [[ "$targetDir" != "." ]] ; then
                pushd "$HOME" > /dev/null

                # Call rmdir with a relative path excluding $HOME.
                # Otherwise, it might try to delete $HOME and exit
                # with a permission error.
                run rmdir $VERBOSE_ARG \
                    -p --ignore-fail-on-non-empty \
                    "$targetDir"

                popd > /dev/null
              fi
            fi
          done
        '';
      in ''
        function linkNewGen() {
          _i "Creating home file links in %s" "$HOME"

          local newGenFiles
          newGenFiles="$(readlink -e "$newGenPath/home-files")"
          find "$newGenFiles" \( -type f -or -type l \) \
            -exec bash ${link} "$newGenFiles" {} +
        }

        function cleanOldGen() {
          if [[ ! -v oldGenPath || ! -e "$oldGenPath/home-files" ]] ; then
            return
          fi

          _i "Cleaning up orphan links from %s" "$HOME"

          local newGenFiles oldGenFiles
          newGenFiles="$(readlink -e "$newGenPath/home-files")"
          oldGenFiles="$(readlink -e "$oldGenPath/home-files")"

          # Apply the cleanup script on each leaf in the old
          # generation. The find command below will print the
          # relative path of the entry.
          find "$oldGenFiles" '(' -type f -or -type l ')' -printf '%P\0' \
            | xargs -0 bash ${cleanup} "$newGenFiles"
        }

        cleanOldGen

        if [[ ! -v oldGenPath || "$oldGenPath" != "$newGenPath" ]] ; then
          _i "Creating profile generation %s" $newGenNum
          if [[ -e "$genProfilePath"/manifest.json ]] ; then
            # Remove all packages from "$genProfilePath"
            # `nix profile remove '.*' --profile "$genProfilePath"` was not working, so here is a workaround:
            nix profile list --profile "$genProfilePath" \
              | cut -d ' ' -f 4 \
              | xargs -rt $DRY_RUN_CMD nix profile remove $VERBOSE_ARG --profile "$genProfilePath"
            run nix profile install $VERBOSE_ARG --profile "$genProfilePath" "$newGenPath"
          else
            run nix-env $VERBOSE_ARG --profile "$genProfilePath" --set "$newGenPath"
          fi

          run --quiet nix-store --realise "$newGenPath" --add-root "$newGenGcPath" --indirect
          if [[ -e "$legacyGenGcPath" ]]; then
            run rm $VERBOSE_ARG "$legacyGenGcPath"
          fi
        else
          _i "No change so reusing latest profile generation %s" "$oldGenNum"
        fi

        linkNewGen
      ''
    );
  };
}
