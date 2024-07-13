{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.git-hooks.flakeModule
    inputs.treefmt-nix.flakeModule

    ./default
    ./git-hooks
    ./lib
    ./shell
    ./templates

    ./args.nix
    ./treefmt.nix
    ./iso-images.nix
  ];
}
