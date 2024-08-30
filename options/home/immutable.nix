# Original code by iosmanthus - https://github.com/iosmanthus/nixos-config/blob/349917b/modules/immutable-file.nix
#
# Immutable home files
#
# This module provides a way to make files in the home directory immutable.
# It is similar to home.file but it uses chattr +i to make the file immutable.
#
# Usage example:
#   home.immutable-file = {
#     fcitx5-profile = {
#       src = ./profile.css;
#       dst = "${config.xdg.configHome}/profile.css";
#     };
#   };
#
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.home.immutable-file;
  immutableFileOpts = _: {
    options = {
      src = mkOption {
        type = types.path;
      };
      dst = mkOption {
        type = types.path;
      };
    };
  };
  mkImmutableFile = pkgs.writeScript "make_immutable_file" ''
    # $1: dst
    # $2: src
    if [ ! -d "$(dirname $1)" ]; then
      mkdir -p $1
    fi

    if [ -f $1 ]; then
        sudo chattr -i $1
    fi

    sudo cp $2 $1
    sudo chattr +i $1
  '';
in {
  options.home.immutable-file = mkOption {
    type = with types; attrsOf (submodule immutableFileOpts);
    default = {};
  };

  config = mkIf (cfg != {}) {
    home.activation =
      mapAttrs'
      (name: {
        src,
        dst,
      }:
        nameValuePair
        "make-immutable-${name}"
        (lib.hm.dag.entryAfter ["writeBoundary"] ''
          ${mkImmutableFile} ${dst} ${src}
        ''))
      cfg;
  };
}
