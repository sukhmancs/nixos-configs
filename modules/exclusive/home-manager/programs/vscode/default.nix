#
# VSCode - Visual Studio Code
#
# Explore available extensions:
#
# $ nix repl
# nix-repl> :lf github:nix-community/nix-vscode-extensions/c43d9089df96cf8aca157762ed0e2ddca9fcd71e
# nix-repl> t = extensions.<TAB>
# nix-repl> t = extensions.x86_64-linux
# nix-repl> t.<TAB>
#
# For more information: https://github.com/nix-community/nix-vscode-extensions#explore
{
  config,
  lib,
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.system};

  # vscode-marketplace, open-vsx-release provides all the latest extensions including
  # those in the vscode-marketplace-release and open-vsx-release channels
  # If you want stable/released extensions, use vscode-marketplace-release and open-vsx-release
  vscodeMarketplaceExtensions = with extensions.vscode-marketplace; [
    golang.go # Go language support
    kahole.magit # Magit - Git support

    (pkgs.callPackage ./theme.nix {} osConfig.modules.themes.colors)

    dhall.dhall-lang # Dhall - Dhall language support
    hashicorp.terraform # Provides support for HashiCorp Terraform
    ritwickdey.liveserver # Live Server - Launch a development local Server with live reload feature for static & dynamic pages
    tamasfe.even-better-toml # TOML language support
    llvm-vs-code-extensions.vscode-clangd # Clangd - C/C++ language support
    stkb.rewrap # Rewrap - rewrap comments and other text
    meraymond.idris-vscode # Idris - Idris language support
    ocamllabs.ocaml-platform # OCaml - OCaml language support
    bierner.markdown-mermaid # Markdown Mermaid - Mermaid diagram support
    golang.go # Go language support
    vlanguage.vscode-vlang # support for Vlang
    vue.volar # language server for Vue
    ms-vscode.vscode-typescript-next # TypeScript
    ms-toolsai.jupyter # Jupyter - Jupyter notebook support
    decaycs.decay # Decay color scheme
    adolfdaniel.vscode-chromium-vector-icons # Chromium Vector Icons
    arrterian.nix-env-selector # Nix environment selector
    bbenoist.nix # Nix language support
    # catppuccin.catppuccin-vsc # Catppuccin Macchiato color scheme
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
    gpoore.codebraid-preview # Preview Pandoc Markdown in VS Code, and execute code blocks and inline code with Codebraid
  ];

  openVsxExtensions = with extensions.open-vsx; [
    rust-lang.rust-analyzer # Rust - Rust language support
  ];

  vscodeMarketplaceExtensionsRelease = with extensions.vscode-marketplace-release; [
    # Add released extensions here
  ];

  openVsxExtensionsRelease = with extensions.open-vsx-release; [
    # Add released extensions here
  ];
in {
  config = mkIf config.programs.vscode.enable {
    programs.vscode = {
      # package = pkgs.vscodium;
      mutableExtensionsDir = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions =
        vscodeMarketplaceExtensions
        ++ openVsxExtensions
        ++ vscodeMarketplaceExtensionsRelease
        ++ openVsxExtensionsRelease
        ++ [
          pkgs.vscode-extensions."2gua".rainbow-brackets # Rainbow Brackets
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "copilot-nightly";
            publisher = "github";
            version = "1.67.7949";
            sha256 = "sha256-ZtUqQeWjXmTz49DUeYkuqSTdVHRC8OfgWv8fuhlHDVc=";
          }
        ];

      userSettings = {
        # General
        "update.mode" = "none";
        "update.showReleaseNotes" = false; # disable update release notes
        "[nix]"."editor.tabSize" = 2;
        "files.trimTrailingWhitespace" = true;
        "redhat.telemetry.enabled" = false;

        # Security settings
        "security.workspace.trust.untrustedFiles" = "open";
        "security.workspace.trust.enabled" = false;

        # BreadCrumbs settings
        "breadcrumbs.enabled" = true;
        "breadcrumbs.filePath" = "off";
        "notebook.breadcrumbs.showCodeCells" = false;

        # Terminal settings
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "terminal.integrated.automationShell.linux" = "nix-shell";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.enableVisualBell" = false;
        "terminal.integrated.tabs.enabled" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = false;
        "terminal.integrated.tabs.separator" = " | ";
        # "terminal.integrated.cursorBlinking" = true;

        # Editor settings
        "editor.fontFamily" = "JetBrainsMono Nerd Font, Material Design Icons, 'monospace', monospace";
        "editor.inlayHints.enabled" = "off";
        "editor.lineNumbers" = "relative";
        "editor.lightbulb.enabled" = "off";
        "editor.scrollbar.verticalScrollbarSize" = 6;
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        # "editor.formatOnPaste" = true;
        # "editor.formatOnSave" = true;
        # "editor.formatOnType" = false;
        "editor.overviewRulerBorder" = false;
        "editor.renderLineHighlight" = "all";
        "editor.inlineSuggest.enabled" = true;
        "editor.smoothScrolling" = true;
        "editor.suggestSelection" = "first";
        "editor.guides.indentation" = true;
        "editor.guides.bracketPairs" = true;
        "editor.bracketPairColorization.enabled" = true;
        "editor.scrollbar.horizontalScrollbarSize" = 0;
        # "editor.minimap.enabled" = false;
        # "editor.minimap.renderCharacters" = false;
        # "editor.cursorBlinking" = "phase";

        # Window settings
        "window.titleBarStyle" = "custom";
        "window.titleSeparator" = " | ";
        "window.title" = "!Neovim";
        "window.nativeTabs" = true;
        "window.restoreWindows" = "all";
        "window.menuBarVisibility" = "toggle";

        # Workbench settings
        "workbench.colorTheme" = "Xi's theme";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.layoutControl.enabled" = false;
        "workbench.editor.enablePreview" = false;
        "workbench.fontAliasing" = "antialiased";
        "workbench.panel.defaultLocation" = "right";
        "workbench.editor.tabCloseButton" = "left";
        "workbench.startupEditor" = "none";
        "workbench.list.smoothScrolling" = true;


        # Git settings
        "git.openRepositoryInParentFolders" = "always";
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;

        # Extension settings
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "github.copilot.enable" = {
          "markdown" = true;
          "plaintext" = true;
        };
        # "vim.useSystemClipboard" = true;
        "haskell.manageHLS" = "PATH";
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
        # "extensions.experimental.affinity" = {
        #   "asvetliakov.vscode-neovim" = 1;
        # };

        # Explorer settings
        "explorer.openEditors.visible" = 1;
        "explorer.compactFolders" = false; # disable compact mode
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.autoReveal" = false;

        # Error Lens settings
        "errorLens.gutterIconsEnabled" = true;
        "errorLens.gutterIconSize" = "115%";
        "errorLens.messageBackgroundMode" = "message";
        "errorLens.enabledDiagnosticLevels" = [
          "error"
          "warning"
          "info"
          "hint"
        ];

        # Linters
        # "python.linting.flake8Args" = [
        #   "--extend-ignore=E501"
        # ];
        # "python.linting.flake8CategorySeverity.F" = "Warning";
        # "flake8.severity" = {
        #   "E" = "Information";
        #   "F" = "Hint";
        #   "W" = "Error";
        # };

        # Formatters for different languages
        "[python]" = {
          # use black vs code extension to format python code
          "editor.defaultFormatter" = "ms-python.black-formatter";
          "editor.formatOnSave" = true;
        };

        "[nix]" = {
          # use alejandra to format nix code
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "alejandra.program" = "alejandra";
      };
      keybindings = [
        {
          key = "ctrl+c";
          command = "editor.action.clipboardCopyAction";
          when = "textInputFocus";
        }
        # Run any selected code in jupyter
        {
          key = "shift+enter";
          command = "jupyter.execSelectionInteractive";
          when = "editorTextFocus && isWorkspaceTrusted && jupyter.ownsSelection && !findInputFocussed && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'";
        }
      ];
    };
  };
}
