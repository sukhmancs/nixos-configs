# Original Code by NotAShelf - https://github.com/notashelf/nyx
_: let
  mkBtrfs = list: list + ["compress=zstd" "noatime"];
in {
  inherit mkBtrfs;
}
