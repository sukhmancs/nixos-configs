{
  programs.nixvim.plugins.copilot-cmp = {
    enable = true;
  };
  #Todo: throws an error nodejs-18_x missing
  # programs.nixvim.plugins.copilot-lua = {
  #   enable = true;
  #   suggestion = {
  #     enabled = false;
  #   };
  #   panel = {
  #     enabled = false;
  #   };
  # };

  programs.nixvim.extraConfigLua = ''
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  '';
}
