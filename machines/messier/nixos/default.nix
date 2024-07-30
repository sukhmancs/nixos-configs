{
  imports = [
    ./programs # system programs

    ./console.nix # console configuration (keymap, font, etc.)
    ./nixpkgs.nix # nixpkgs configuration (allowbroken, allowUnfree, etc.)
    ./users.nix # users available on the system
  ];
}
