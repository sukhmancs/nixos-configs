#
# Zellij - Terminal multiplexer with batteries included
#
{osConfig, ...}: {
  programs.zellij = {
    enable = true;
  };

  programs.zsh.shellAliases = {
    "zj" = "zellij";
  };

  xdg.configFile."zellij/config.kdl".source = import ./config.nix {inherit osConfig;};
}
