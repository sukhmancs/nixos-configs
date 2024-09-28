{
  description = "Starter skeleton for a pybind11 project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs: {
    overlays = {
      # This placeholder is for adding packages for development overlay.
      dev = final: prev: {};

      # The default overlay adds the resulting pybind11 package.
      default = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (py-final: py-prev: {
            starterpp = py-final.callPackage ./nix/default.nix {};
          })
        ];
      };
    };
  } // utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: let
    pkgs-dev = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.dev ];
    };

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
    };

  in {
    devShells.default = pkgs-dev.callPackage ./nix/dev-shell.nix {
      stdenv = pkgs-dev.clang16Stdenv;
      clang-tools = pkgs-dev.clang-tools_16;
    };

    # Normally you do not need this playground dev shell. Put it here just for
    # testing purpose so that we can explicitly test the resulting package.
    devShells.playground = pkgs.mkShell {
      packages = [
        (pkgs.python3.withPackages (pyPkgs: with pyPkgs; [
          starterpp
        ]))
      ];
    };
      
    packages.default = pkgs.python3Packages.starterpp;
  });
}
