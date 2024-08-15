#
# lib.packagesFromDirectoryRecursive is a function that loads packages from a directory recursively.
#
# For example:
#
# For the following directory structure:
# packages/
# ├── anime4k
# │   └── package.nix
# ├── nicksfetch
# │   └── package.nix
# └── ...
#
# The following code:
#
#  lib.packagesFromDirectoryRecursive {
#   callPackage = pkgs.callPackage;
#   directory = ./packages;
# }
#
# will produce the following output:
#
# {
#   anime4k = callPackage ./packages/anime4k/package.nix {};
#   nicksfetch = callPackage ./packages/nicksfetch/package.nix {};
#   ...
# }
#
{
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: let
    # Define the directory for packages explicitly at the top for clarity
    packagesDirectory = ./packages;
  in {
    # Directly use the 'config.packages' for 'overlayAttrs'
    overlayAttrs = config.packages;

    # Use 'lib.packagesFromDirectoryRecursive' to load packages from the specified directory
    packages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = packagesDirectory;
    };
  };
}
