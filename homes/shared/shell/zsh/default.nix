{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./aliases.nix
    ./init.nix
    ./plugins.nix
  ];

  config = {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true; # we handle this ourself
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          comment = "fg=#585b70";
          alias = "fg=#a6e3a1";
          suffix-alias = "fg=#a6e3a1";
          global-alias = "fg=#a6e3a1";
          function = "fg=#a6e3a1";
          command = "fg=#a6e3a1";
          precommand = "fg=#a6e3a1,italic";
          autodirectory = "fg=#fab387,italic";
          single-hyphen-option = "fg=#fab387";
          double-hyphen-option = "fg=#fab387";
          back-quoted-argument = "fg=#cba6f7";
          ## Keywords
          ## Built ins
          builtin = "fg=#a6e3a1";
          reserved-word = "fg=#a6e3a1";
          hashed-command = "fg=#a6e3a1";
          ## Punctuation
          commandseparator = "fg=#f38ba8";
          command-substitution-delimiter = "fg=#cdd6f4";
          command-substitution-delimiter-unquoted = "fg=#cdd6f4";
          process-substitution-delimiter = "fg=#cdd6f4";
          back-quoted-argument-delimiter = "fg=#f38ba8";
          back-double-quoted-argument = "fg=#f38ba8";
          back-dollar-quoted-argument = "fg=#f38ba8";
          ## Serializable / Configuration Languages
          ## Storage
          ## Strings
          command-substitution-quoted = "fg=#f9e2af";
          command-substitution-delimiter-quoted = "fg=#f9e2af";
          single-quoted-argument = "fg=#f9e2af";
          single-quoted-argument-unclosed = "fg=#eba0ac";
          double-quoted-argument = "fg=#f9e2af";
          double-quoted-argument-unclosed = "fg=#eba0ac";
          rc-quote = "fg=#f9e2af";
          ## Variables
          dollar-quoted-argument = "fg=#cdd6f4";
          dollar-quoted-argument-unclosed = "fg=#eba0ac";
          dollar-double-quoted-argument = "fg=#cdd6f4";
          assign = "fg=#cdd6f4";
          named-fd = "fg=#cdd6f4";
          numeric-fd = "fg=#cdd6f4";
          ## No category relevant in spec
          unknown-token = "fg=#eba0ac";
          path = "fg=#cdd6f4,underline";
          path_pathseparator = "fg=#f38ba8,underline";
          path_prefix = "fg=#cdd6f4,underline";
          path_prefix_pathseparator = "fg=#f38ba8,underline";
          globbing = "fg=#cdd6f4";
          history-expansion = "fg=#cba6f7";
          #command-substitution = "fg=?";
          #command-substitution-unquoted = "fg=?";
          #process-substitution = "fg=?";
          #arithmetic-expansion = "fg=?";
          back-quoted-argument-unclosed = "fg=#eba0ac";
          redirection = "fg=#cdd6f4";
          arg0 = "fg=#cdd6f4";
          default = "fg=#cdd6f4";
          cursor = "fg=#cdd6f4";
        };
      };
      sessionVariables = {LC_ALL = "en_US.UTF-8";};

      history = {
        # share history between different zsh sessions
        share = true;

        # avoid cluttering $HOME with the histfile
        path = "${config.xdg.dataHome}/zsh/zsh_history";

        # saves timestamps to the histfile
        extended = true;

        # optimize size of the histfile by avoiding duplicates
        # or commands we don't need remembered
        save = 100000;
        size = 100000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignorePatterns = ["rm *" "pkill *" "kill *" "killall *"];
      };

      # dirhashes are easy aliases to commonly used directoryies
      # e.g. `cd ~dl` would take you to $HOME/Downloads
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
