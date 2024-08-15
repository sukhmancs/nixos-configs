{lib, ...}:{
  # Don't store coredumps from systemd-coredump.
  systemd.coredump.extraConfig = lib.mkDefault ''
    Storage=none
  '';
}