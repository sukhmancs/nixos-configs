{
  osConfig,
  lib,
  ...
}:
with lib; let
  inherit (osConfig) home;
  cfg = home.immutable-file;

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
