{inputs, pkgs, ...}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./colorscheme.nix
    ./extra.nix
    ./extraplug.nix
    ./keymap.nix
    ./plug.nix
  ];

  config = {
    programs.nixvim = {
      enable = true;
    };
  };
}
