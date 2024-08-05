#
# VSCode - Visual Studio Code
#
{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.programs.vscode.enable {
    programs.vscode = {
      # package = (pkgs.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: rec {
      #   src = builtins.fetchTarball {
      #     url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
      #     sha256 = "15ili2kmhpbbks2mba73w7pv0ba41wq45qbn4waxjx78r38kb74y"; # In the first build, an error might occur if the SHA256 value changes. Check the error message for the new SHA256 value and update it accordingly.
      #   };
      #   version = "latest";

      #   buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
      # });
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions;
        [
          arrterian.nix-env-selector
          bbenoist.nix
          catppuccin.catppuccin-vsc
          christian-kohler.path-intellisense
          dbaeumer.vscode-eslint
          eamodio.gitlens
          esbenp.prettier-vscode
          formulahendry.code-runner
          golang.go
          ibm.output-colorizer
          kamadorueda.alejandra
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode-remote.remote-ssh
          ms-vscode.cpptools

          naumovs.color-highlight
          #ms-python.black-formatter
          svelte.svelte-vscode
          ms-vsliveshare.vsliveshare
          oderwat.indent-rainbow
          pkief.material-icon-theme
          rust-lang.rust-analyzer
          shardulm94.trailing-spaces
          sumneko.lua
          timonwong.shellcheck
          usernamehw.errorlens
          xaver.clang-format
          yzhang.markdown-all-in-one
          james-yu.latex-workshop
          redhat.vscode-yaml
          ms-azuretools.vscode-docker
          irongeek.vscode-env
          github.vscode-pull-request-github
          github.codespaces
          astro-build.astro-vscode
          wakatime.vscode-wakatime
        ]
        ++ [
          pkgs.vscode-extensions."2gua".rainbow-brackets
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "copilot-nightly";
            publisher = "github";
            version = "1.67.7949";
            sha256 = "sha256-ZtUqQeWjXmTz49DUeYkuqSTdVHRC8OfgWv8fuhlHDVc=";
          }
          #          {
          #            name = "volar";
          #            publisher = "vue";
          #            version = "1.0.12";
          #            sha256 = "sha256-D9E3KRUOlNVXH4oMv1W0+/mbqO8Se7+6E2F5P/KvCro=";
          #          }
          {
            name = "vscode-typescript-vue-plugin";
            publisher = "vue";
            version = "1.0.12";
            sha256 = "sha256-WiL+gc9+U861ubLlY/acR+ZcrFT7TdIDR0K1XNNidX8=";
          }
          {
            name = "decay";
            publisher = "decaycs";
            version = "1.0.6";
            sha256 = "sha256-Jtxj6LmHgF7UNaXtXxHkq881BbuPtIJGxR7kdhKr0Uo=";
          }
          {
            name = "vscode-typescript-next";
            publisher = "ms-vscode";
            version = "5.0.202301100";
            sha256 = "sha256-8d/L9F06ZaS9dTOXV6Q40ivI499nfZLQURcLdHXoTSM=";
          }
          {
            name = "vscode-chromium-vector-icons";
            publisher = "adolfdaniel";
            version = "1.0.2";
            sha256 = "sha256-Meo53e/3jUP6YDEXOA/40xghI77jj4iAQus3/S8RPZI=";
          }
        ];
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "explorer.compactFolders" = false; # disable compact mode
        "update.showReleaseNotes" = false; # disable update release notes
        "catppuccin.accentColor" = "mauve";
        "editor.fontFamily" = "JetBrainsMono Nerd Font, Material Design Icons, 'monospace', monospace";
        "editor.inlayHints.enabled" = "off";
        "git.openRepositoryInParentFolders" = "always";
        "editor.lineNumbers" = "relative";
        "breadcrumbs.filePath" = "off";
        "workbench.layoutControl.enabled" = false;
        "editor.lightbulb.enabled" = "off";
        "notebook.breadcrumbs.showCodeCells" = false;
        "workbench.editor.enablePreview" = false;
        "editor.scrollbar.verticalScrollbarSize" = 6;
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "workbench.fontAliasing" = "antialiased";
        "files.trimTrailingWhitespace" = true;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "window.titleBarStyle" = "custom";
        "terminal.integrated.automationShell.linux" = "nix-shell";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.enableVisualBell" = false;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.overviewRulerBorder" = false;
        "editor.renderLineHighlight" = "all";
        "editor.inlineSuggest.enabled" = true;
        "editor.smoothScrolling" = true;
        "editor.suggestSelection" = "first";
        "editor.guides.indentation" = true;
        "editor.guides.bracketPairs" = true;
        "editor.bracketPairColorization.enabled" = true;
        "window.nativeTabs" = true;
        "window.restoreWindows" = "all";
        "window.menuBarVisibility" = "toggle";
        "workbench.panel.defaultLocation" = "right";
        "workbench.editor.tabCloseButton" = "left";
        "workbench.startupEditor" = "none";
        "workbench.list.smoothScrolling" = true;
        "security.workspace.trust.enabled" = false;

        "terminal.integrated.tabs.enabled" = true;
        "editor.scrollbar.horizontalScrollbarSize" = 0;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "explorer.confirmDelete" = false;
        "redhat.telemetry.enabled" = false;
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "flake8.severity" = {
          "E" = "Information";
          "F" = "Hint";
          "W" = "Error";
        };
        "window.titleSeparator" = " | ";
        "terminal.integrated.enableMultiLinePasteWarning" = false;
        "explorer.openEditors.visible" = 1;
        # "editor.cursorBlinking" = "phase";
        "terminal.integrated.tabs.separator" = " | ";
        "git.autofetch" = true;
        "explorer.confirmDragAndDrop" = false;
        "explorer.autoReveal" = false;
        "errorLens.gutterIconsEnabled" = true;
        "errorLens.gutterIconSize" = "115%";
        "errorLens.messageBackgroundMode" = "message";
        "errorLens.enabledDiagnosticLevels" = [
          "error"
          "warning"
          "info"
          "hint"
        ];
        "window.title" = "!Neovim";

        "python.linting.flake8Args" = [
          "--extend-ignore=E501"
        ];

        #"[python]" = {
          # use black vs code extension to format python code
          #"editor.defaultFormatter" = "ms-python.black-formatter";
          #"editor.formatOnSave" = true;
        #};

        "python.linting.flake8CategorySeverity.F" = "Warning";
        # "vscode-neovim.highlightGroups.highlights" = {
        #   "IncSearch" = {
        #     "backgroundColor" = "theme.editor.findMatchBackground";
        #     "borderColor" = "theme.editor.findMatchBorder";
        #   };
        #   "Search" = {
        #     "backgroundColor" = "theme.editor.findMatchHighlightBackground";
        #     "borderColor" = "theme.editor.findMatchHighlightBorder";
        #   };
        #   "Visual" = {
        #     "backgroundColor" = "theme.editor.selectionBackground";
        #   };
        # };
        "breadcrumbs.enabled" = true;
        "github.copilot.enable" = {
          "markdown" = true;
          "plaintext" = true;
        };
      };

      keybindings = [
        {
          key = "ctrl+c";
          command = "editor.action.clipboardCopyAction";
          when = "textInputFocus";
        }
        {
          key = "shift+enter";
          command = "jupyter.execSelectionInteractive";
          when = "editorTextFocus && isWorkspaceTrusted && jupyter.ownsSelection && !findInputFocussed && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'";
        }
      ];
    };
  };
}
