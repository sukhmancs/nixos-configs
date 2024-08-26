{
  pkgs,
  osConfig,
  ...
}: {
  programs.bat = {
    enable = true;
    themes = {
      custom = {
        src = import ./theme.nix {inherit osConfig;};
        file = "custom.tmTheme";
      };
    };
    config = {
      pager = "less -FR"; # frfr
    };
  };
}
