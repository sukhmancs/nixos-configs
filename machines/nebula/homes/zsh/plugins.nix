{pkgs, ...}: let
  inherit (pkgs) fetchFromGitHub;
in {
  programs.zsh.plugins = [
    {
      # Must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
      name = "fzf-tab";
      src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
    }
  ];
}
