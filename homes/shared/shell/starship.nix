{
  config,
  pkgs,
  ...
}: let
  starshipConfigDir = "/home/xi/.config";
  starshipConfigFile = "${starshipConfigDir}/starship.toml";
  perlScript = pkgs.writeScript "generate_starship_config.pl" ''
    #! /usr/bin/env nix-shell
    #! nix-shell -i perl -p perl

    use 5.014;
    use warnings;

    chomp(my $hostname = `hostname`);

    my $char = $ENV{USER} eq 'root' ? '#' : '\\\\$';
    my $user = $ENV{USER} eq 'root' ? 'bright-red' : 'bright-blue';
    my $host = {
      'milkyway' => '#cba6f7',
      'andromeda' => 'bright-yellow',
      'leto' => 'purple',
      'gaea' => 'green',
      'hornet' => 'red',
    }->{$hostname} // 'yellow';

    while (<DATA>) {
      s/\@\@CHAR\@\@/$char/;
      s/\@\@USER\@\@/$user/;
      s/\@\@HOST\@\@/$host/;
      print;
    }

    __DATA__
    format = """
    \\($directory(|$git_branch$git_commit$git_status(|$git_state))\\)( $python) $fill ($cmd_duration )($battery )$username@$hostname [\\[](host)$time[\\]](host) $line_break\
    $status @@CHAR@@
    """
    right_format = '$character'
    add_newline = false
    palette = 'local'

    [directory]
    format = '$path$read_only'
    style = 'bg'
    repo_root_format = '$before_root_path$repo_root$path$read_only'
    repo_root_style = 'git'
    fish_style_pwd_dir_length = 1

    [git_state]
    format = '$state(:$progress_current/$progress_total)'
    style = 'git'
    rebase = 'r'
    merge = 'm'
    revert = 'v'
    cherry_pick = 'c'
    bisect = 'b'
    am = 'a'
    am_or_rebase = 'r'

    [git_branch]
    format = '$branch(:$remote_branch)'
    style = 'git'
    ignore_branches = ['main', 'master', 'HEAD']

    [git_commit]
    format = '$hash$tag'
    style = 'git'

    [git_status]
    format = '$all_status$ahead_behind'
    style = 'bold git'
    modified = '*'
    stashed = ""
    diverged = '+$ahead_count-$behind_count'
    ahead = '+$count'
    behind = '-$count'

    [kubernetes]
    disabled = false
    format = '$symbol$context'
    symbol = '☸ '
    style = 'bg'

    [pulumi]
    format = '$symbol$stack'
    symbol = ' '
    style = 'bg'

    [python]
    format = '(🐍$virtualenv)'
    style = 'bg'

    [fill]
    symbol = '─'
    style = 'bg'

    [cmd_duration]
    format = '\($duration\)'
    style = 'bg'

    [battery]
    format = '$symbol'
    unknown_symbol = ""

    [[battery.display]]
    threshold = 5
    charging_symbol = '⚡️ '
    discharging_symbol = ' '
    style = 'bright-red'

    [[battery.display]]
    threshold = 15
    charging_symbol = '⚡️ '
    discharging_symbol = ' '
    style = 'red'

    [[battery.display]]
    threshold = 40
    charging_symbol = '⚡️ '
    discharging_symbol = ' '
    style = 'yellow'

    [[battery.display]]
    threshold = 80
    charging_symbol = '⚡️ '
    discharging_symbol = ' '
    style = 'bright-black'

    [[battery.display]]
    threshold = 100
    charging_symbol = '⚡️ '
    discharging_symbol = ' '
    style = 'green'

    [username]
    disabled = false
    format = '$user'
    style_user = 'user'
    show_always = true

    [hostname]
    disabled = false
    format = '$hostname'
    style = 'host'
    ssh_only = false

    [time]
    disabled = false
    format = '$time'
    style = 'bg'

    [line_break]

    [status]
    disabled = false
    format = '$status'

    [character]
    format = '$symbol'
    success_symbol = ""
    error_symbol = ""
    vimcmd_symbol = '[\[NOR\]](bright-yellow)'

    [palettes.local]
    bg = 'bright-black'
    git = 'green'
    user = '@@USER@@'
    host = '@@HOST@@'
  '';

  shellScript = pkgs.writeScript "update_starship_config.sh" ''
    #!/bin/sh
    ${perlScript} > ${starshipConfigFile}
  '';
in {
  config = {
    home.packages = with pkgs; [
      perl
    ];

    programs.starship = {
      enable = true;
    };

    systemd.user.services.updateStarshipConfig = {
      Unit = {
        Description = "Update Starship Config";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${shellScript}";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    systemd.user.timers.updateStarshipConfig = {
      Unit = {
        Description = "Timer for updating Starship Config";
      };
      Timer = {
        OnCalendar = "*:0/5"; # Every 5 minutes
        Persistent = true;
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
# {
#   config,
#   osConfig,
#   lib,
#   pkgs,
#   ...
# }: let
#   inherit (builtins) map;
#   inherit (lib.strings) concatStrings;
#   inherit (osConfig) modules;
#   inherit (modules.themes) colors;
#   hostname = builtins.getEnv "HOST";
#   userStyle =
#     if builtins.getEnv "USER" == "root"
#     then "bright-red"
#     else "bright-blue";
#   hostStyle = lib.lists.foldl' (acc: x:
#     if x.key == hostname
#     then x.value
#     else acc) "${colors.base0E}" [
#     {
#       key = "milkyway";
#       value = "${colors.base05}";
#     }
#     {
#       key = "andromeda";
#       value = "${colors.base09}";
#     }
#     {
#       key = "leto";
#       value = "${colors.base06}";
#     }
#     {
#       key = "erebus";
#       value = "${colors.base0B}";
#     }
#     {
#       key = "gaea";
#       value = "${colors.base0A}";
#     }
#   ];
#   charSymbol =
#     if builtins.getEnv "USER" == "root"
#     then "#"
#     else "\\$";
# in {
#   home = {
#     sessionVariables = {
#       STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
#     };
#   };
#   programs.starship = {
#     enable = true;
#     settings = {
#       scan_timeout = 2;
#       command_timeout = 2000; # nixpkgs makes starship implode with lower values
#       format = ''
#         [\(](host)$os$directory([|](host)$shell$nix_shell)([|](host)$git_branch$git_commit$git_status([|](host)$git_state))[\)](host)( $python) $fill ($cmd_duration )($battery )$username[@](bg)$hostname [\[](host)$time[\]](host) $line_break$status [${charSymbol}](user)
#       '';
#       right_format = "$character";
#       add_newline = false;
#       palette = "local";
#       directory = {
#         truncation_length = 2;
#         substitutions = {
#           "~/Dev" = "Dev";
#           "~/Documents" = "󰈙 ";
#           "~/Downloads" = " ";
#           "~/Music" = " ";
#           "~/Pictures" = " ";
#           "~" = " ";
#         };
#         format = "[$path]($style)[$read_only]($read_only_style) ";
#         style = "bg";
#         repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
#         repo_root_style = "git";
#         fish_style_pwd_dir_length = 1;
#       };
#       os = {
#         disabled = false;
#         format = "[ $symbol ]($style)";
#       };
#       # os
#       os.symbols = {
#         NixOS = "󱄅";
#       };
#       # git
#       git_state = {
#         format = "[$state(:$progress_current/$progress_total)]($style)";
#         style = "git";
#         rebase = "r";
#         merge = "m";
#         revert = "v";
#         cherry_pick = "c";
#         bisect = "b";
#         am = "a";
#         am_or_rebase = "r";
#       };
#       git_commit = {
#         format = "[$hash$tag]($style)";
#         style = "git";
#         commit_hash_length = 7;
#       };
#       git_branch = {
#         format = "[$branch(:$remote_branch)]($style)";
#         style = "bold purple"; #git
#         ignore_branches = ["main" "master" "HEAD"];
#       };
#       git_status = {
#         format = "[$all_status$ahead_behind]($style)";
#         style = "bold git";
#         modified = "!";
#         stashed = "";
#         deleted = "✘ ";
#         conflicted = " ";
#         untracked = "?";
#         renamed = "»";
#         diverged = "+$ahead_count-$behind_count";
#         ahead = "+$count";
#         behind = "-$count";
#       };
#       kubernetes = {
#         disabled = false;
#         format = "[$symbol$context]($style)";
#         symbol = "☸ ";
#         style = "bg";
#       };
#       pulumi = {
#         format = "[$symbol$stack]($style)";
#         symbol = " ";
#         style = "bg";
#       };
#       python = {
#         format = "([🐍$virtualenv]($style))";
#         symbol = "[ ](blue) ";
#         style = "bg";
#       };
#       fill = {
#         symbol = "─";
#         style = "bg";
#       };
#       cmd_duration = {
#         disabled = false;
#         format = "[ 󱦟 $duration ]($style)";
#         show_milliseconds = true;
#         min_time = 0;
#         style = "bg";
#       };
#       battery = {
#         format = "[$symbol]($style)";
#         unknown_symbol = "";
#         display = [
#           {
#             threshold = 5;
#             charging_symbol = "⚡️ ";
#             discharging_symbol = " ";
#             style = "bright-red";
#           }
#           {
#             threshold = 15;
#             charging_symbol = "⚡️ ";
#             discharging_symbol = " ";
#             style = "red";
#           }
#           {
#             threshold = 40;
#             charging_symbol = "⚡️ ";
#             discharging_symbol = " ";
#             style = "yellow";
#           }
#           {
#             threshold = 80;
#             charging_symbol = "⚡️ ";
#             discharging_symbol = " ";
#             style = "bright-black";
#           }
#           {
#             threshold = 100;
#             charging_symbol = "⚡️ ";
#             discharging_symbol = " ";
#             style = "green";
#           }
#         ];
#       };
#       username = {
#         disabled = false;
#         format = "[$user]($style)";
#         style_user = "user";
#         show_always = true;
#       };
#       hostname = {
#         disabled = false;
#         format = "[$hostname]($style)";
#         style = "host";
#         ssh_only = false;
#       };
#       time = {
#         disabled = false;
#         format = "[$time]($style)";
#         style = "bg";
#       };
#       line_break = {};
#       status = {
#         disabled = false;
#         format = "[$status]($style)";
#       };
#       character = {
#         format = "[ $symbol ]($style)";
#         success_symbol = "[](bold green)";
#         error_symbol = "[](bold red)";
#         vimcmd_symbol = "[\\[NOR\\]](bright-yellow)";
#         vimcmd_replace_one_symbol = "[R](bold green)";
#         vimcmd_replace_symbol = "[R](bold green)";
#         vimcmd_visual_symbol = "[V](bold green)";
#       };
#       palettes = {
#         local = {
#           bg = "bright-black";
#           git = "green";
#           user = userStyle;
#           host = hostStyle;
#         };
#       };
#       # language configurations
#       # the whitespaces at the end *are* necessary for proper formatting
#       lua.symbol = "[ ](blue) ";
#       rust.symbol = "[ ](red) ";
#       nix_shell.symbol = "[󱄅 ](blue) ";
#       golang.symbol = "[󰟓 ](blue)";
#       c.symbol = "[ ](black)";
#       nodejs.symbol = "[󰎙 ](yellow)";
#       package.symbol = "📦 ";
#     };
#   };
# }

