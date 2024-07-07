{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) map;
  inherit (lib.strings) concatStrings;

  hostname = builtins.getEnv "HOST";
  userStyle =
    if builtins.getEnv "USER" == "root"
    then "bright-red"
    else "bright-blue";
  hostStyle = lib.lists.foldl' (acc: x:
    if x.key == hostname
    then x.value
    else acc) "yellow" [
    {
      key = "mz-doy1";
      value = "bright-white";
    }
    {
      key = "tozt";
      value = "bright-yellow";
    }
    {
      key = "partofme";
      value = "purple";
    }
    {
      key = "mail";
      value = "green";
    }
    {
      key = "hornet";
      value = "red";
    }
  ];
  charSymbol =
    if builtins.getEnv "USER" == "root"
    then "#"
    else "\\$";
in {
  home = {
    sessionVariables = {
      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
    };
  };

  programs.starship = let
    elemsConcatted = concatStrings (
      map (s: "\$${s}") [
        "hostname"
        "username"
        "directory"
        "shell"
        "nix_shell"
        "git_branch"
        "git_commit"
        "git_state"
        "git_status"
        "jobs"
        "cmd_duration"
      ]
    );
  in {
    enable = true;

    settings = {
      scan_timeout = 2;
      command_timeout = 2000; # nixpkgs makes starship implode with lower values
      # add_newline = false;

      format = ''
        $directory$git_branch$git_commit$git_status$git_state( $python) $fill($cmd_duration)($battery)$username@$hostname $time $line_break$status ${charSymbol}
      '';
      right_format = "$character";
      add_newline = false;
      palette = "local";
      # line_break.disabled = false;

      # format = "${elemsConcatted}\n$character";

      # configure specific elements
      # character = {
      #   error_symbol = "[](bold red)";
      #   success_symbol = "[](bold green)";
      #   vicmd_symbol = "[](bold yellow)";
      #   format = "$symbol [|](bold bright-black) ";
      # };

      # username = {
      #   format = "[$user]($style) in ";
      # };

      directory = {
        truncation_length = 2;

        # # removes the read_only symbol from the format, it doesn't play nicely with my folder icon
        # format = "[ ](bold green) [$path]($style) ";

        # the following removes tildes from the path, and substitutes some folders with shorter names
        substitutions = {
          "~/Dev" = "Dev";
          "~/Documents" = "Docs";
        };

        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bg";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
        repo_root_style = "git";
        fish_style_pwd_dir_length = 1;
      };

      # git
      git_state = {
        format = "[$state(:$progress_current/$progress_total)]($style)";
        style = "git";
        rebase = "r";
        merge = "m";
        revert = "v";
        cherry_pick = "c";
        bisect = "b";
        am = "a";
        am_or_rebase = "r";
      };
      # git_commit.commit_hash_length = 7;
      git_commit = {
        format = "[$hash$tag]($style)";
        style = "git";
        commit_hash_length = 7;
      };
      # git_branch.style = "bold purple";

      git_branch = {
        format = "[$branch(:$remote_branch)]($style)";
        style = "git";
        ignore_branches = "['main' 'master' 'HEAD']";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "bold git";
        modified = "!";
        stashed = "";
        staged = "+";
        deleted = "✘ ";
        conflicted = " ";
        untracked = "?";
        renamed = "»";
        diverged = "+$ahead_count-$behind_count";
        ahead = "+$count";
        behind = "-$count";
      };

      kubernetes = {
        disabled = false;
        format = "[$symbol$context]($style)";
        symbol = "☸ ";
        style = "bg";
      };

      pulumi = {
        format = "[$symbol$stack]($style)";
        symbol = " ";
        style = "bg";
      };

      python = {
        format = "([🐍$virtualenv]($style))";
        symbol = "[ ](blue) ";
        style = "bg";
      };

      fill = {
        symbol = "─";
        style = "bg";
      };

      cmd_duration = {
        format = "[\($duration\)]($style)";
        style = "bg";
      };

      battery = {
        format = "[$symbol]($style)";
        unknown_symbol = "";
        display = [
          {
            threshold = 5;
            charging_symbol = "⚡️ ";
            discharging_symbol = " ";
            style = "bright-red";
          }
          {
            threshold = 15;
            charging_symbol = "⚡️ ";
            discharging_symbol = " ";
            style = "red";
          }
          {
            threshold = 40;
            charging_symbol = "⚡️ ";
            discharging_symbol = " ";
            style = "yellow";
          }
          {
            threshold = 80;
            charging_symbol = "⚡️ ";
            discharging_symbol = " ";
            style = "bright-black";
          }
          {
            threshold = 100;
            charging_symbol = "⚡️ ";
            discharging_symbol = " ";
            style = "green";
          }
        ];
      };

      username = {
        disabled = false;
        format = "[$user]($style)";
        style_user = "user";
        show_always = true;
      };

      hostname = {
        disabled = false;
        format = "[$hostname]($style)";
        style = "host";
        ssh_only = false;
      };

      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "bg";
      };

      line_break = {};

      status = {
        disabled = false;
        format = "[$status]($style)";
      };

      character = {
        format = "$symbol";
        success_symbol = "";
        error_symbol = "";
        vimcmd_symbol = "[\\[NOR\\]](bright-yellow)";
      };

      palettes = {
        local = {
          bg = "bright-black";
          git = "green";
          user = userStyle;
          host = hostStyle;
        };
      };

      # language configurations
      # the whitespaces at the end *are* necessary for proper formatting
      lua.symbol = "[ ](blue) ";
      rust.symbol = "[ ](red) ";
      nix_shell.symbol = "[󱄅 ](blue) ";
      golang.symbol = "[󰟓 ](blue)";
      c.symbol = "[ ](black)";
      nodejs.symbol = "[󰎙 ](yellow)";
      package.symbol = "📦 ";
    };
  };
}
