{
  config,
  lib,
  ...
}: {
  imports = [
    ./nixos # Nixos system modules

    ./colors.nix # color scheme for the system
  ];

  # since we don't inherit the core module, this needs to be set here manually
  # otherwise we'll see the stateVersion error - which doesn't actually matter inside the ISO
  # but still annoying and slows down nix flake check
  system.stateVersion = "23.11";
}
