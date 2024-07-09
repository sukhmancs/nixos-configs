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
  programs.starship = {
    enable = true;
    settings = {
      scan_timeout = 2;
      command_timeout = 2000; # nixpkgs makes starship implode with lower values
      format = ''
        [\(](${hostStyle})$directory([|](${hostStyle})$shell$nix_shell)([|](${hostStyle})$git_branch$git_commit$git_status([|](${hostStyle})$git_state))[\)](${hostStyle})( $python) $fill ($cmd_duration )($battery )$username[@](bg)$hostname [\[](${hostStyle})$time[\]](${hostStyle}) $line_break$status [${charSymbol}](${userStyle})
      '';
      right_format = "$character";
      add_newline = false;
      palette = "local";

      directory = {
        truncation_length = 2;
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

      git_commit = {
        format = "[$hash$tag]($style)";
        style = "git";
        commit_hash_length = 7;
      };

      git_branch = {
        format = "[$branch(:$remote_branch)]($style)";
        style = "bold purple"; #git
        ignore_branches = ["main" "master" "HEAD"];
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "bold git";
        modified = "!";
        stashed = "";
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
