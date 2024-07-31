{
  imports = [
    ./misc
    ./services

    ./boot.nix
    ./environment.nix
    ./hardware.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./security.nix
    ./users.nix
  ];

  system.nixos.tags = ["iso-image"];
}
