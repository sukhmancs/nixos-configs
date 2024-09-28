{
  description = "An awesome javascript/typescript web application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, utils, devshell, ... }@inputs:
    utils.lib.eachDefaultSystem (system: {
      devShell =
        let
          pkgs = import nixpkgs {
            inherit system;

            overlays = [ devshell.overlays.default ];
          };
        in
        pkgs.devshell.mkShell {
          name = "js-webapp-basics";

          commands = with pkgs; [
            { name = "yarn"; package = yarn; }
            { name = "node"; package = nodejs; }
            { name = "create-react-app"; package = nodePackages.create-react-app; }
          ];
        };
    });
}
