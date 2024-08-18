{ config, osConfig, lib, ... }:
{
  imports = [
    ./autocommands.nix
    ./keys.nix
    ./sets.nix
    ./highlight.nix
    ./plugins/colorscheme
    ./plugins/completion
    ./plugins/git
    ./plugins/lsp
    ./plugins/snippets
    ./plugins/statusline
    ./plugins/treesitter
    ./plugins/ui
    ./plugins/utils
  ];
  config = {
    programs.nixvim.extraConfigLua = ''
      _G.theme = "custom";
    '';
  };
}
