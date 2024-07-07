{
  imports = [
    ./loaders # per-bootloader configurations
    ./generic.nix # generic configuration, such as kernel and tmpfs setup
    ./plymouth.nix # plymouth boot splash
  ];
}
