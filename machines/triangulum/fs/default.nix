{
  # imports = [./external.nix];
  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/68550fbd-e747-47b1-8426-8c037073f9a0";
      fsType = "ext4";
    };

    swapDevices = [];
  };
}
