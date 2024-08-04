#
# Lazygit - simple terminal UI for git commands
#
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "quit";

      gui = {
        theme = {
          unstagedChangesColor = ["red" "bold"];
          selectedLineBgColor = ["#263c42"];
          selectedRangeBgColor = ["#263c42"];
        };
      };

      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };

      keybinding = {
        universal = {
          gotoTop = "g";
          gotoBottom = "G";
        };
        commits = {
          viewResetOptions = "m";
        };
        stash = {
          popStash = "o";
        };
      };
    };
  };
}
