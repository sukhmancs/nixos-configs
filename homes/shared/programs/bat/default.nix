{pkgs, ...}: let
  catppuccin = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
    hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
  });
in {
  programs.bat = {
    enable = true;
    themes = {
      custom = {
        # src = pkgs.fetchFromGitHub {
        #   owner = "catppuccin";
        #   repo = "bat";
        #   rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        #   sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        # };
        src = import ./theme.nix { inherit osConfig;};
        file = "custom.tmTheme";
      };
    };
    config = {
      theme = "custom";
      pager = "less -FR"; # frfr
    };
  };
}
