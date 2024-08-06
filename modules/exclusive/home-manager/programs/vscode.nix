#
# VSCode - Visual Studio Code
#
{
  lib,
  pkgs,
  system,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.system};
  inherit (pkgs) vscode-with-extensions vscodium;

  vscodeMarketplaceExtensions = with extensions.vscode-marketplace; [
    golang.go # Go language support
    vlanguage.vscode-vlang # support for Vlang
    vue.vscode-typescript-vue-plugin # Vue
    vue.volar # language server for Vue
    ms-vscode.vscode-typescript-next # TypeScript
    decaycs.decay # Decay color scheme
    adolfdaniel.vscode-chromium-vector-icons # Chromium Vector Icons
    arrterian.nix-env-selector # Nix environment selector
    bbenoist.nix # Nix language support
    catppuccin.catppuccin-vsc # Catppuccin Macchiato color scheme
    christian-kohler.path-intellisense # Path Intellisense - autocompletion for file paths
    dbaeumer.vscode-eslint # ESLint - JavaScript linting
    eamodio.gitlens # GitLens - For enhanced Git integration
    esbenp.prettier-vscode # Prettier - Code formatter
    formulahendry.code-runner # Code Runner - run code snippet or code file for multiple languages
    ibm.output-colorizer # Output Colorizer - colorize the output in the debug console
    kamadorueda.alejandra # Alejandra formatter for nix
    ms-azuretools.vscode-docker # Docker - Docker support
    ms-python.python # Python - Python language support
    ms-python.vscode-pylance # Pylance - Python language server
    ms-vscode-remote.remote-ssh # Remote - SSH - SSH support
    ms-vscode.cpptools # C/C++ - C/C++ language support
    naumovs.color-highlight # Color Highlight - highlight web colors in your editor
    ms-python.black-formatter # Black - Python code formatter
    svelte.svelte-vscode # Svelte - Svelte language support
    ms-vsliveshare.vsliveshare # Live Share - Real-time collaborative development
    oderwat.indent-rainbow # Indent Rainbow - colorize indentation in front of your text
    pkief.material-icon-theme # Material Icon Theme - Material Design icons
    shardulm94.trailing-spaces # Trailing Spaces - highlight trailing spaces and delete them in a flash
    sumneko.lua # Lua - Lua language support
    timonwong.shellcheck # ShellCheck - Shell script linting
    usernamehw.errorlens # Error Lens - display diagnostics inline
    xaver.clang-format # Clang-Format - C/C++ code formatter
    yzhang.markdown-all-in-one # Markdown All in One - Markdown language support
    james-yu.latex-workshop # LaTeX Workshop - LaTeX language support
    redhat.vscode-yaml # YAML - YAML language support
    irongeek.vscode-env # .env - .env file support
    github.vscode-pull-request-github # GitHub Pull Requests - GitHub pull request support
    github.codespaces # GitHub Codespaces - GitHub Codespaces support
    astro-build.astro-vscode # Astro - Astro language support
    wakatime.vscode-wakatime # WakaTime - WakaTime support
  ];

  openVsxExtensions = with extensions.open-vsx-release; [
    rust-lang.rust-analyzer
  ];
in {
  config = mkIf true {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions =
        vscodeMarketplaceExtensions
        ++ openVsxExtensions
        # extensions = with pkgs.vscode-extensions;
        #   [
        #     arrterian.nix-env-selector
        #     bbenoist.nix
        #     catppuccin.catppuccin-vsc
        #     christian-kohler.path-intellisense
        #     dbaeumer.vscode-eslint
        #     eamodio.gitlens
        #     esbenp.prettier-vscode
        #     formulahendry.code-runner
        #     golang.go
        #     ibm.output-colorizer
        #     kamadorueda.alejandra
        #     ms-azuretools.vscode-docker
        #     ms-python.python
        #     ms-python.vscode-pylance
        #     ms-vscode-remote.remote-ssh
        #     ms-vscode.cpptools
        #     naumovs.color-highlight
        #     ms-python.black-formatter
        #     svelte.svelte-vscode
        #     ms-vsliveshare.vsliveshare
        #     oderwat.indent-rainbow
        #     pkief.material-icon-theme
        #     rust-lang.rust-analyzer
        #     shardulm94.trailing-spaces
        #     sumneko.lua
        #     timonwong.shellcheck
        #     usernamehw.errorlens
        #     xaver.clang-format
        #     yzhang.markdown-all-in-one
        #     james-yu.latex-workshop
        #     redhat.vscode-yaml
        #     ms-azuretools.vscode-docker
        #     irongeek.vscode-env
        #     github.vscode-pull-request-github
        #     github.codespaces
        #     astro-build.astro-vscode
        #     wakatime.vscode-wakatime
        #   ]
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
          #          {
          #            name = "vscode-typescript-vue-plugin";
          #            publisher = "vue";
          #            version = "1.0.12";
          #            sha256 = "sha256-WiL+gc9+U861ubLlY/acR+ZcrFT7TdIDR0K1XNNidX8=";
          #          }
          #          {
          #            name = "decay";
          #            publisher = "decaycs";
          #            version = "1.0.6";
          #            sha256 = "sha256-Jtxj6LmHgF7UNaXtXxHkq881BbuPtIJGxR7kdhKr0Uo=";
          #          }
          #          {
          #            name = "vscode-typescript-next";
          #            publisher = "ms-vscode";
          #            version = "5.0.202301100";
          #            sha256 = "sha256-8d/L9F06ZaS9dTOXV6Q40ivI499nfZLQURcLdHXoTSM=";
          #          }
          #          {
          #            name = "vscode-chromium-vector-icons";
          #            publisher = "adolfdaniel";
          #            version = "1.0.2";
          #            sha256 = "sha256-Meo53e/3jUP6YDEXOA/40xghI77jj4iAQus3/S8RPZI=";
          #          }
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

        "[python]" = {
          # use black vs code extension to format python code
          "editor.defaultFormatter" = "ms-python.black-formatter";
          "editor.formatOnSave" = true;
        };

        "python.linting.flake8CategorySeverity.F" = "Warning";
        "vscode-neovim.highlightGroups.highlights" = {
          "IncSearch" = {
            "backgroundColor" = "theme.editor.findMatchBackground";
            "borderColor" = "theme.editor.findMatchBorder";
          };
          "Search" = {
            "backgroundColor" = "theme.editor.findMatchHighlightBackground";
            "borderColor" = "theme.editor.findMatchHighlightBorder";
          };
          "Visual" = {
            "backgroundColor" = "theme.editor.selectionBackground";
          };
        };
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
