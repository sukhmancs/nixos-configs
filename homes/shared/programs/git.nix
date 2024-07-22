{
  osConfig,
  pkgs,
  ...
}: let
  gitPackage = pkgs.gitFull;
in {
  config = {
    home.packages = with pkgs; [
      gist # manage github gists
      act # local github actions
      delta # pager
      tig # repository browser
    ];

    programs.git = {
      enable = true;
      package = gitPackage;

      # my credentials
      userName = "racoot";
      userEmail = "63659772+sukhmancs@users.noreply.github.com"; # i wonder why i don't wanna reveal my email

      # lets sign using our own key
      # this must be provided by the host
      signing = {
        key = null;
        signByDefault = false;
      };

      lfs = {
        enable = true;
        skipSmudge = true;
      };

      aliases = {
        br = "branch";
        c = "commit -m";
        ca = "commit -am";
        co = "checkout";
        d = "diff";
        df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
        fuck = "commit --amend -m";
        graph = "log --all --decorate --graph";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
        st = "status";
        hist = ''
          log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
        '';
        llog = ''
          log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
        '';
      };

      ignores = [
        # COMMON
        ".cache/"
        ".DS_Store"
        "auto-save-list"
        "*.elc"

        # IDE
        ".idea/"
        "*.swp"
        ".~lock*"

        # NPM
        "node_modules"

        # Nix
        ".direnv/"
        "result"
        "result-*"

        # C
        ".tags"
        "tags"
        "*~"
        "*.o"
        "*.so"
        "*.cmake"
        "CMakeCache.txt"
        "CMakeFiles/"
        "cmake-build-debug/"
        "compile_commands.json"
        ".ccls*"

        # Python
        "venv"
        ".venv"
        "*pyc"
        "*.egg-info/"
        "__pycached__/"
        ".mypy_cache"
      ];

      extraConfig = {
        # I don't care about the usage of the term "master"
        # but main is easier to type, so that's that
        init.defaultBranch = "main";

        core = {
          # set delta as the main pager
          pager = "delta";

          # disable the horrendous GUI password prompt
          # for Git when SSH authentication fails
          askPass = "";

          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        };

        # prefer using libsecret for storing and retrieving credentials
        credential.helper = "${gitPackage}/bin/git-credential-libsecret";

        # delta is some kind of a syntax highlighting pager for git
        # it looks nice but I'd like to consider difftastic at some point
        delta = {
          enable = true;
          features = "decorations side-by-side navigate";
          whitespace-error-style = "22 reverse";
          side-by-side = true;
          true-color = "always";

          options = {
            dark = true;
            navigate = true;
            line-numbers = true;
            side-by-side = true;
            syntax-theme = "base16-256";
          };

          # line numbers are nice
          line-numbers = true;
          line-numbers-left-format = "";
          line-numbers-right-format = "│ ";

          # theming
          plus-style = "syntax \"#003800\"";
          minus-style = "syntax \"#3f0001\"";

          # configure decorations
          decorations = {
            commit-decoration-style = "cyan bold box ul";
            file-style = "cyan bold ul";
            file-decoration-style = "cyan bold ul";
            hunk-header-decoration-style = "cyan box ul";
          };
        };

        interactive.diffFilter = "delta --color-only --features=interactive";

        branch.autosetupmerge = "true";
        pull.ff = "only";
        color.ui = "auto";
        repack.usedeltabaseoffset = "true";

        push = {
          default = "current";
          followTags = true;
          autoSetupRemote = true;
        };

        merge = {
          conflictstyle = "diff3";
          stat = "true";
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
        };

        rerere = {
          autoupdate = true;
          enabled = true;
        };

        url = {
          "https://github.com/".insteadOf = "github:";
          "ssh://git@github.com/".pushInsteadOf = "github:";
          "https://gitlab.com/".insteadOf = "gitlab:";
          "ssh://git@gitlab.com/".pushInsteadOf = "gitlab:";
          "https://aur.archlinux.org/".insteadOf = "aur:";
          "ssh://aur@aur.archlinux.org/".pushInsteadOf = "aur:";
          "https://git.sr.ht/".insteadOf = "srht:";
          "ssh://git@git.sr.ht/".pushInsteadOf = "srht:";
          "https://codeberg.org/".insteadOf = "codeberg:";
          "ssh://git@codeberg.org/".pushInsteadOf = "codeberg:";
        };
      };
    };
  };
}
