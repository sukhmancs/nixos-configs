{inputs, pkgs, ...}:

let

  nixvim' = inputs.nixvim.legacyPackages.${pkgs.stdenv.system};
  nvim = nixvim'.makeNixvimWithModule {
    inherit pkgs;
    module = ./config;
  };

in {
  home.packages = [ nvim ];
}
