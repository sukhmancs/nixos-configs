{
  description = "An awesome langchain project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    utils.url = "github:numtide/flake-utils";

    ml-pkgs.url = "github:nixvital/ml-pkgs";
    ml-pkgs.inputs.nixpkgs.follows = "nixpkgs";
    ml-pkgs.inputs.utils.follows = "utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays.dev = nixpkgs.lib.composeManyExtensions [
      inputs.ml-pkgs.overlays.torch-family
      inputs.ml-pkgs.overlays.apis
      inputs.ml-pkgs.overlays.langchain

      # You can put your other overlays here, inline or with import. For example
      # if you want to put an inline overlay, uncomment below:
      #
      # (final: prev: {
      #   pythonPackagesExtension = prev.pythonPackagesExtension ++ [
      #     (python-final: python-prev: {
      #       my-package = ...;
      #     })
      #   ];
      # })
    ];
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ self.overlays.dev ];
        };
    in {
      devShells.default = let
        python-env = pkgs.python3.withPackages (pyPkgs: with pyPkgs; [
          numpy
          openai
          langchain
        ] ++ (with langchain.passthru.optional-dependencies; utils));

        name = "langchain-basics";
      in pkgs.mkShell {
        inherit name;

        packages = [
          python-env
        ];

        shellHooks = let pythonIcon = "f3e2"; in ''
          export PS1="$(echo -e '\u${pythonIcon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };
    });
}
