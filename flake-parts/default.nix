{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.git-hooks.flakeModule
    inputs.treefmt-nix.flakeModule

    ./lib
    ./default
    ./git-hooks

    ./args.nix
    ./treefmt.nix
    ./iso-images.nix
    ./shell
  ];
}
