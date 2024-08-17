{inputs, pkgs, ...}:

let

  nixvim' = inputs.nixvim.legacyPackages.${pkgs.stdenv.system};
  nvim = nixvim'.makeNixvimWithModule {
    inherit pkgs osConfig;
    module = ./config;
  };

in {
  home.packages = [ nvim ];
}
