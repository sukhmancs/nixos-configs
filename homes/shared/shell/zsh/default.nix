#
# Zsh - the Z shell
#
{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
  in {
  imports = [
    ./aliases.nix
    ./init.nix
    ./plugins.nix
  ];

  config = {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          comment = "fg=#${colors.base03}";
          alias = "fg=#${colors.base0E}";
          suffix-alias = "fg=#${colors.base0E}";
          global-alias = "fg=#${colors.base0E}";
          function = "fg=#${colors.base0E}";
          command = "fg=#${colors.base0E}";
          precommand = "fg=#${colors.base0E},italic";
          autodirectory = "fg=#${colors.base09},italic";
          single-hyphen-option = "fg=#${colors.base09}";
          double-hyphen-option = "fg=#${colors.base09}";
          back-quoted-argument = "fg=#${colors.base0E}"; # highlights hello in echo `hello`
          ## Keywords
          ## Built ins
          builtin = "fg=#${colors.base0E}"; # highlights echo in echo hello
          reserved-word = "fg=#${colors.base0E}";
          hashed-command = "fg=#${colors.base0E}";
          ## Punctuation
          commandseparator = "fg=#${colors.base08}"; # highlights ; in echo hello; echo world
          command-substitution-delimiter = "fg=#${colors.base05}"; # highlights $( in echo $(echo hello)
          command-substitution-delimiter-unquoted = "fg=#${colors.base05}"; # highlights $( in echo $(echo hello)
          process-substitution-delimiter = "fg=#${colors.base05}"; # highlights < in echo <(echo hello)
          back-quoted-argument-delimiter = "fg=#${colors.base08}"; # highlights ` in echo `hello`
          back-double-quoted-argument = "fg=#${colors.base08}"; # highlights $HOME in echo `$HOME`
          back-dollar-quoted-argument = "fg=#${colors.base08}"; # highlights $HOME in echo `$HOME`
          ## Serializable / Configuration Languages
          ## Storage
          ## Strings
          command-substitution-quoted = "fg=#${colors.base0A}"; # highlights hello - echo "hello"
          command-substitution-delimiter-quoted = "fg=#${colors.base0A}"; # highlights $(,  and ) in echo "hello"
          single-quoted-argument = "fg=#${colors.base0A}"; # highlights hello in echo 'hello'
          single-quoted-argument-unclosed = "fg=#${colors.base08}"; # highlights hello in echo 'hello
          double-quoted-argument = "fg=#${colors.base0A}"; # highlights hello in echo "hello"
          double-quoted-argument-unclosed = "fg=#${colors.base08}"; # highlights hello in echo "hello
          rc-quote = "fg=#${colors.base0A}"; # highlights hello in echo `hello`
          ## Variables
          dollar-quoted-argument = "fg=#${colors.base05}"; # highlights $HOME in echo $HOME
          dollar-quoted-argument-unclosed = "fg=#${colors.base08}"; # highlights $HOME in echo $HOME
          dollar-double-quoted-argument = "fg=#${colors.base05}"; # highlights $HOME in echo "$HOME"
          assign = "fg=#${colors.base05}"; # highlights HOME in HOME=~/Documents
          named-fd = "fg=#${colors.base05}"; # highlights 3 in echo hello >&3
          numeric-fd = "fg=#${colors.base05}"; # highlights 3 in echo hello >&3
          ## No category relevant in spec
          unknown-token = "fg=#${colors.base08}"; # highlights hello in echo hello
          path = "fg=#${colors.base05},underline"; # highlights, underline paths such as /home/user
          path_pathseparator = "fg=#${colors.base08},underline"; # highlights path separators such as / in /home/user
          path_prefix = "fg=#${colors.base05},underline"; # highlights path prefixes
          path_prefix_pathseparator = "fg=#${colors.base08},underline";
          globbing = "fg=#${colors.base05}"; # highlights * in echo *
          history-expansion = "fg=#${colors.base0E}"; # highlights ! in echo !!
          #command-substitution = "fg=?";
          #command-substitution-unquoted = "fg=?";
          #process-substitution = "fg=?";
          #arithmetic-expansion = "fg=?";
          back-quoted-argument-unclosed = "fg=#${colors.base08}"; # highlights hello in echo `hello
          redirection = "fg=#${colors.base05}"; # highlights > in echo hello > file
          arg0 = "fg=#${colors.base05}"; # highlights echo in echo hello
          default = "fg=#${colors.base05}"; # default color for text
          cursor = "fg=#${colors.base0E}"; # highlights the cursor
        };
      };
      sessionVariables = {LC_ALL = "en_US.UTF-8";};

      history = {
        # where to save the history
        path = "${config.xdg.dataHome}/zsh/zsh_history";

        # how many lines to remember
        extended = true;

        # how many lines to save
        save = 100000;
        size = 100000;

        # expire duplicates meaning if you run the same command multiple times
        # only the last one will be saved
        expireDuplicatesFirst = true;

        # share history between all sessions
        share = true;

        # don't save duplicates
        ignoreDups = true;

        # ignore these patterns
        ignorePatterns = ["rm *" "pkill *" "kill *" "killall *"];

        # ignore commands that start with a space
        ignoreSpace = true;

      };

      # aliases for different directories
      dirHashes = {
        docs = "$HOME/Documents";
        dl = "$HOME/Downloads";
        media = "$HOME/Media";
        vids = "$HOME/Media/Videos";
        music = "$HOME/Media/Music";
        pics = "$HOME/Media/Pictures";
        screenshots = "$HOME/Media/Pictures/Screenshots";
        notes = "$HOME/Cloud/Notes";
        dev = "$HOME/Dev";
        dots = "$HOME/.config/nyx";
      };

      # Disable /etc/{zshrc,zprofile} that contains the "sane-default" setup out of the box
      # in order avoid issues with incorrect precedence to our own zshrc.
      # See `/etc/zshrc` for more info.
      envExtra = ''
        setopt no_global_rcs
      '';
    };
  };
}
