{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
  ];

  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
