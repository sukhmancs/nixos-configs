#
# gh - GitHub CLI
#
{pkgs, ...}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    extensions = with pkgs; [
      gh-poi
      gh-cal
      gh-eco
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "nvim";
      pager = "delta -s";
      aliases = {
        co = "pr checkout";
        al = "alias list";
        il = "issue list";
        iv = "issue view --comments";
        rl = "repo list";
        rv = "repo view";
        gv = "gist view";
        st = "status";
      };
      browser = "$BROWSER";
    };
  };
}
