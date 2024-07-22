#
# Starship Prompt
#
# This configuration also keeps track of the hostname and changes the prompt
# accordingly. The prompt is a bit more colorful and has a few more features
# than the default configuration. The prompt file is updated everytime user
# logs in. This prompt does not get applied to the root user (because we are
# using home-manager).
#
{
  config,
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  starshipConfigDir = "$HOME/.config";
  starshipConfigFile = "${starshipConfigDir}/starship.toml";
  perlScript = pkgs.writeScript "generate_starship_config.pl" ''
    #!/usr/bin/env perl

    use 5.014;
    use warnings;

    chomp(my $hostname = `hostname`);

    my $char = $ENV{USER} eq 'root' ? '#' : '\\\\$';
    my $user = $ENV{USER} eq 'root' ? 'bright-red' : 'bright-blue';
    my $host = {
      'milkyway' => '#${colors.base0E}',
      'andromeda' => '#${colors.base0D}',
      'leto' => '#${colors.base07}',
      'gaea' => '#${colors.base0B}',
      'hornet' => '#${colors.base08}',
    }->{$hostname} // '#${colors.base06}';

    while (<DATA>) {
      s/\@\@CHAR\@\@/$char/;
      s/\@\@USER\@\@/$user/;
      s/\@\@HOST\@\@/$host/;
      print;
    }

    __DATA__
    format = """
    \\([$os$directory](host)(|$shell$nix_shell|$git_branch$git_commit$git_status(|[$git_state](host)))\\)( $python) $fill ($cmd_duration )($battery )$username@[$hostname](host) [\\[](host)$time[\\]](host) $line_break\
    $status @@CHAR@@
    """
    right_format = '$character'
    add_newline = false
    palette = 'local'

    [os]
    disabled = false
    format = '[ $symbol ]($style)'

    [os.symbols]
    NixOS = '󱄅'

    [directory]
    format = '$path$read_only'
    style = 'bg'
    repo_root_format = '$before_root_path$repo_root$path$read_only'
    repo_root_style = 'git'
    fish_style_pwd_dir_length = 1

    # [directory.substitutions]
    # '~/Dev' = 'Dev'
    # '~/Documents' = '󰈙 '
    # '~/Downloads' = ' '
    # '~/Music' = ' '
    # '~/Pictures' = ' '
    # '~' = ' '

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
    deleted = '✘'
    stashed = ""
    renamed = '»'
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

    [lua]
    symbol = '[ ](#${colors.base07}) '

    [rust]
    symbol = '[ ](#${colors.base08}) '

    [nix_shell]
    symbol = '[󱄅 ](#${colors.base07}) '

    [golang]
    symbol = '[󰟓 ](#${colors.base06})'

    [c]
    symbol = '[ ](#${colors.base01})'

    [nodejs]
    symbol = '[󰎙 ](#${colors.base0A})'

    [package]
    symbol = '📦 '

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
    format = '[ $symbol ]($style)'
    success_symbol = '[✓](bold green)'
    error_symbol = '[✗](bold red)'
    vimcmd_symbol = '[\[NOR\]](#${colors.base09})'
    vimcmd_replace_one_symbol = '[R](bold green)'
    vimcmd_replace_symbol = '[R](bold green)'
    vimcmd_visual_symbol = '[V](bold green)'

    [palettes.local]
    bg = '#${colors.base04}'
    git = '#${colors.base0B}'
    user = '@@USER@@'
    host = '@@HOST@@'
  '';

  shellScript = pkgs.writeScript "update_starship_config.sh" ''
    #!/bin/sh
    ${perlScript} > ${starshipConfigFile}
  '';
in {
  config = {
    programs.starship = {
      enable = true;
    };

    home.packages = with pkgs; [
      perl
    ];

    # Update Starship Config everytime user logs in. This way I can keep track
    # of the hostname and change the prompt accordingly.
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
        OnBootSec = "5s"; # 5 seconds after login
        Persistent = true;
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
