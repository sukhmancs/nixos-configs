{lib, ...}:{
    # Limit access to nix to users with the "wheel" group. ("sudoers")
  nix.settings.allowed-users = lib.mkForce [ "@wheel" ];
}