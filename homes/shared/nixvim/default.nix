{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
    # ./autocmd.nix
    # ./colorscheme.nix
    # ./extra.nix
    # ./extraplug.nix
    # ./highlight.nix
    # ./keymap.nix
    # ./plug.nix
    # ./opts.nix
  ];

  config = {
    programs.nixvim = {
      enable = true;
    };
  };
}
