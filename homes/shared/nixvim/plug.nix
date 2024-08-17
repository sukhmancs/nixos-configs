{pkgs, osConfig, ...}:
let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in
{
  programs.nixvim = {
    plugins = {

      # gitlinker - Open github/gitlab links in browser
      gitlinker = {
        enable = true;
        callbacks = {
          "github.com" = "get_github_type_url";
          "gitlab.dnm.radiofrance.fr" = "get_github_type_url";
        };
      };

      # gitsigns - Git signs in the gutter
      gitsigns = {
        enable = true;
        settings = {
          trouble = true;
          current_line_blame = true;
          signs = {
            add = {
              text = "│";
            };
            change = {
              text = "│";
            };
            delete = {
              text = "_";
            };
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
            untracked = {
              text = "│";
            };
          };
        };
      };

      # lazygit - TUI for git
      lazygit = {
        enable = true;
      };

      # git-worktree - Manage git worktrees
      git-worktree = {
        enable = true;
        enableTelescope = true;
      };

      # conform-nvim - LSP based code formatting
      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notifyOnError = true;
        formattersByFt = {
          liquidsoap = [ "liquidsoap-prettier" ];
          html = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          css = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          javascript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          javascriptreact = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          typescript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          typescriptreact = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          markdown = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          yaml = [
            "yamllint"
            "yamlfmt"
          ];
        };
      };

      # fidget - Progress and notification manager
      fidget = {
        enable = true;
        logger = {
          level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          floatPrecision = 1.0e-2; # Limit the number of decimals displayed for floats
        };
        progress = {
          pollRate = 0; # How and when to poll for progress messages
          suppressOnInsert = true; # Suppress new messages while in insert mode
          ignoreDoneAlready = false; # Ignore new tasks that are already complete
          ignoreEmptyMessage = false; # Ignore new tasks that don't contain a message
          clearOnDetach =
            # Clear notification group when LSP server detaches
            ''
              function(client_id)
                local client = vim.lsp.get_client_by_id(client_id)
                return client and client.name or nil
              end
            '';
          notificationGroup =
            # How to get a progress message's notification group key
            ''
              function(msg) return msg.lsp_client.name end
            '';
          ignore = [ ]; # List of LSP servers to ignore
          lsp = {
            progressRingbufSize = 0; # Configure the nvim's LSP progress ring buffer size
          };
          display = {
            renderLimit = 16; # How many LSP messages to show at once
            doneTtl = 3; # How long a message should persist after completion
            doneIcon = "✔"; # Icon shown when all LSP progress tasks are complete
            doneStyle = "Constant"; # Highlight group for completed LSP tasks
            progressTtl = "math.huge"; # How long a message should persist when in progress
            progressIcon = {
              pattern = "dots";
              period = 1;
            }; # Icon shown when LSP progress tasks are in progress
            progressStyle = "WarningMsg"; # Highlight group for in-progress LSP tasks
            groupStyle = "Title"; # Highlight group for group name (LSP server name)
            iconStyle = "Question"; # Highlight group for group icons
            priority = 30; # Ordering priority for LSP notification group
            skipHistory = true; # Whether progress notifications should be omitted from history
            formatMessage = ''
              require ("fidget.progress.display").default_format_message
            ''; # How to format a progress message
            formatAnnote = ''
              function (msg) return msg.title end
            ''; # How to format a progress annotation
            formatGroupName = ''
              function (group) return tostring (group) end
            ''; # How to format a progress notification group's name
            overrides = {
              rust_analyzer = {
                name = "rust-analyzer";
              };
            }; # Override options from the default notification config
          };
        };
        notification = {
          pollRate = 10; # How frequently to update and render notifications
          filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          historySize = 128; # Number of removed messages to retain in history
          overrideVimNotify = true;
          redirect = ''
            function(msg, level, opts)
              if opts and opts.on_open then
                return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
              end
            end
          '';
          configs = {
            default = "require('fidget.notification').default_config";
          };

          window = {
            normalHl = "Comment";
            winblend = 0;
            border = "none"; # none, single, double, rounded, solid, shadow
            zindex = 45;
            maxWidth = 0;
            maxHeight = 0;
            xPadding = 1;
            yPadding = 0;
            align = "bottom";
            relative = "editor";
          };
          view = {
            stackUpwards = true; # Display notification items from bottom to top
            iconSeparator = " "; # Separator between group name and icon
            groupSeparator = "---"; # Separator between notification groups
            groupSeparatorHl =
              # Highlight group used for group separator
              "Comment";
          };
        };
      };

      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          eslint = {
            enable = true;
          };
          html = {
            enable = true;
          };
          lua-ls = {
            enable = true;
          };
          nil-ls = {
            enable = true;
          };
          marksman = {
            enable = true;
          };
          pyright = {
            enable = true;
          };
          gopls = {
            enable = true;
          };
          terraformls = {
            enable = true;
          };
          tsserver = {
            enable = false;
          };
          yamlls = {
            enable = true;
          };
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
          };
        };
      };

      # lspsaga - LSP UI
      lspsaga = {
        enable = true;
        beacon = {
          enable = true;
        };
        ui = {
          border = "rounded"; # One of none, single, double, rounded, solid, shadow
          codeAction = "💡"; # Can be any symbol you want 💡
        };
        hover = {
          openCmd = "!floorp"; # Choose your browser
          openLink = "gx";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        symbolInWinbar = {
          enable = true; # Breadcrumbs
        };
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = [
              "<Esc>"
              "q"
            ];
          };
        };
        lightbulb = {
          enable = false;
          sign = false;
          virtualText = true;
        };
        implement = {
          enable = false;
        };
        rename = {
          autoSave = false;
          keys = {
            exec = "<CR>";
            quit = [
              "<C-k>"
              "<Esc>"
            ];
            select = "x";
          };
        };
        outline = {
          autoClose = true;
          autoPreview = true;
          closeAfterJump = true;
          layout = "normal"; # normal or float
          winPosition = "right"; # left or right
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };
        scrollPreview = {
          scrollDown = "<C-f>";
          scrollUp = "<C-b>";
        };
      };

      # none-ls - LSP based code formatting
      none-ls = {
        enable = true;
        enableLspFormat = true;
        settings = {
          updateInInsert = false;
        };
        sources = {
          code_actions = {
            gitsigns.enable = true;
            statix.enable = true;
          };
          diagnostics = {
            statix.enable = true;
            yamllint.enable = true;
          };
          formatting = {
            nixpkgs_fmt.enable = true;
            black = {
              enable = true;
              settings = ''
                {
                  extra_args = { "--fast" },
                }
              '';
            };
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
              settings = ''
                {
                  extra_args = { "--no-semi", "--single-quote" },
                }
              '';
            };
            stylua.enable = true;
            yamlfmt.enable = true;
          };
        };
      };

      # trouble - LSP diagnostics
      trouble = {
        enable = true;
      };

      # luasnip - Snippets engine
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };

      # lualine - Statusline
      lualine = {
        enable = true;
        globalstatus = true;
        disabledFiletypes = {
          statusline = [
            "dashboard"
            "alpha"
            "starter"
          ];
        };
        theme = {
          normal = {
            a = {
              bg = "#nil";
            };
            b = {
              bg = "nil";
            };
            c = {
              bg = "nil";
            };
            z = {
              bg = "nil";
            };
            y = {
              bg = "nil";
            };
          };
        };
        inactiveSections = {
          lualine_x = [
            "filename"
            "filetype"
          ];
        };
        sections = {
          lualine_a = [
            {
              name = "mode";
              fmt = "string.lower";
              color = {
                fg = "#${osConfig.modules.themes.colors.base04}";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          ];
          lualine_b = [
            {
              name = "branch";
              icon = "";
              color = {
                fg = "#${osConfig.modules.themes.colors.base04}";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
            {
              name = "diff";
              separator.left = "";
              separator.right = "";
            }
          ];
          lualine_c = [
            {
              name = "diagnostic";
              extraConfig = {
                symbols = {
                  error = " ";
                  warn = " ";
                  info = " ";
                  hint = "󰝶 ";
                };
              };
              color = {
                fg = "#${osConfig.modules.themes.colors.base08}";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          ];
          lualine_x = [ "" ];
          lualine_y = [
            {
              name = "filetype";
              extraConfig = {
                icon_only = true;
              };
              separator.left = "";
              separator.right = "";
            }
            {
              name = "filename";
              extraConfig = {
                symbols = {
                  modified = "";
                  readonly = "👁️";
                  unnamed = "";
                };
              };
              color = {
                fg = "#${osConfig.modules.themes.colors.base05}";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          ];
          lualine_z = [
            {
              name = "location";
              color = {
                fg = "#${osConfig.modules.themes.colors.base05}";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          ];
        };
      };

      # telescope - Fuzzy finder
      telescope = {
        enable = true;
        extensions = {
          file-browser = {
            enable = true;
          };
          fzf-native = {
            enable = true;
          };
        };
        settings = {
          defaults = {
            layout_config = {
              horizontal = {
                prompt_position = "top";
              };
            };
            sorting_strategy = "ascending";
          };
        };
        keymaps = {
          "<leader><space>" = {
            action = "find_files";
            options = {
              desc = "Find project files";
            };
          };
          "<leader>/" = {
            action = "live_grep";
            options = {
              desc = "Grep (root dir)";
            };
          };
          "<leader>:" = {
            action = "command_history";
            options = {
              desc = "Command History";
            };
          };
          "<leader>b" = {
            action = "buffers";
            options = {
              desc = "+buffer";
            };
          };
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Find project files";
            };
          };
          "<leader>fr" = {
            action = "live_grep";
            options = {
              desc = "Find text";
            };
          };
          "<leader>fR" = {
            action = "resume";
            options = {
              desc = "Resume";
            };
          };
          "<leader>fg" = {
            action = "oldfiles";
            options = {
              desc = "Recent";
            };
          };
          "<leader>fb" = {
            action = "buffers";
            options = {
              desc = "Buffers";
            };
          };
          "<C-p>" = {
            action = "git_files";
            options = {
              desc = "Search git files";
            };
          };
          "<leader>gc" = {
            action = "git_commits";
            options = {
              desc = "Commits";
            };
          };
          "<leader>gs" = {
            action = "git_status";
            options = {
              desc = "Status";
            };
          };
          "<leader>sa" = {
            action = "autocommands";
            options = {
              desc = "Auto Commands";
            };
          };
          "<leader>sb" = {
            action = "current_buffer_fuzzy_find";
            options = {
              desc = "Buffer";
            };
          };
          "<leader>sc" = {
            action = "command_history";
            options = {
              desc = "Command History";
            };
          };
          "<leader>sC" = {
            action = "commands";
            options = {
              desc = "Commands";
            };
          };
          "<leader>sD" = {
            action = "diagnostics";
            options = {
              desc = "Workspace diagnostics";
            };
          };
          "<leader>sh" = {
            action = "help_tags";
            options = {
              desc = "Help pages";
            };
          };
          "<leader>sH" = {
            action = "highlights";
            options = {
              desc = "Search Highlight Groups";
            };
          };
          "<leader>sk" = {
            action = "keymaps";
            options = {
              desc = "Keymaps";
            };
          };
          "<leader>sM" = {
            action = "man_pages";
            options = {
              desc = "Man pages";
            };
          };
          "<leader>sm" = {
            action = "marks";
            options = {
              desc = "Jump to Mark";
            };
          };
          "<leader>so" = {
            action = "vim_options";
            options = {
              desc = "Options";
            };
          };
          "<leader>sR" = {
            action = "resume";
            options = {
              desc = "Resume";
            };
          };
          "<leader>uC" = {
            action = "colorscheme";
            options = {
              desc = "Colorscheme preview";
            };
          };
        };
      };

      # indent-blankline - Indentation guides
      indent-blankline = {
        enable = true;
      };

      # noice - Notifications
      noice = {
        enable = true;
        notify = {
          enabled = false;
        };
        messages = {
          enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason
        };
        lsp = {
          message = {
            enabled = true;
          };
          progress = {
            enabled = false;
            view = "mini";
          };
        };
        popupmenu = {
          enabled = true;
          backend = "nui";
        };
        format = {
          filter = {
            pattern = [
              ":%s*%%s*s:%s*"
              ":%s*%%s*s!%s*"
              ":%s*%%s*s/%s*"
              "%s*s:%s*"
              ":%s*s!%s*"
              ":%s*s/%s*"
            ];
            icon = "";
            lang = "regex";
          };
          replace = {
            pattern = [
              ":%s*%%s*s:%w*:%s*"
              ":%s*%%s*s!%w*!%s*"
              ":%s*%%s*s/%w*/%s*"
              "%s*s:%w*:%s*"
              ":%s*s!%w*!%s*"
              ":%s*s/%w*/%s*"
            ];
            icon = "󱞪";
            lang = "regex";
          };
        };
      };

      # nvim-notify - Notifications
      notify = {
        enable = true;
        backgroundColour = "#000000";
        fps = 60;
        render = "default";
        timeout = 1000;
        topDown = true;
      };

      # bufferline - Bufferline
      bufferline = {
        enable = true;
        separatorStyle = "thin"; # “slant”, “padded_slant”, “slope”, “padded_slope”, “thick”, “thin”
        highlights = {
          fill = {
            fg = "none";
            bg = "none";
          };
          background = {
            fg = "#${colors.base03}";
            bg = "#${colors.base01}";
          };
          bufferSelected = {
            fg = "#${colors.base05}";
            italic = false;
          };
          bufferVisible = {
            fg = "#${colors.base03}";
            bg = "#${colors.base00}";
          };
          closeButton = {
            fg = "#${colors.base03}";
            bg = "#${colors.base01}";
          };
          closeButtonVisible = {
            fg = "#${colors.base03}";
            bg = "#${colors.base01}";
          };
          closeButtonSelected = {
            fg = "#${colors.base08}";
          };

          indicatorSelected = {
            fg = "#${colors.base00}";
          };
          indicatorVisible = {
            fg = "#${colors.base00}";
            bg = "#${colors.base00}";
          };
          separator = {
            fg = "#${colors.base01}";
            bg = "#${colors.base01}";
          };
          modified = {
            fg = "#${colors.base03}";
            bg = "#${colors.base00}";
          };
          modifiedVisible = {
            fg = "#${colors.base00}";
            bg = "#${colors.base00}";
          };
          modifiedSelected = {
            fg = "#${colors.base0B}";
          };
          tabClose = {
            fg = "#${colors.base00}";
            bg = "#${colors.base00}";
          };
          duplicate = {
            fg = "#${colors.base03}";
            bg = "#${colors.base01}";
          };
        };
      };

      # alpha - Dashboard
      alpha =
      let
        nixFlake = [
          "                                              "
          " ██╗  ██╗██╗    ██╗      █████╗ ██╗███╗   ██╗ "
          " ╚██╗██╔╝██║    ██║     ██╔══██╗██║████╗  ██║ "
          "  ╚███╔╝ ██║    ██║     ███████║██║██╔██╗ ██║ "
          "  ██╔██╗ ██║    ██║     ██╔══██║██║██║╚██╗██║ "
          " ██╔╝ ██╗██║    ███████╗██║  ██║██║██║ ╚████║ "
          " ╚═╝  ╚═╝╚═╝    ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ "
          "                                              "
          "        github:sukhmancs/nixos-configs        "
        ];
      in
      {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 4;
          }
          {
            opts = {
              hl = "AlphaHeader";
              position = "center";
            };
            type = "text";
            val = nixFlake;
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val =
              let
                mkButton = shortcut: cmd: val: hl: {
                  type = "button";
                  inherit val;
                  opts = {
                    inherit hl shortcut;
                    keymap = [
                      "n"
                      shortcut
                      cmd
                      { }
                    ];
                    position = "center";
                    cursor = 0;
                    width = 40;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                };
              in
              [
                (mkButton "f" "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>" "🔍 Find File"
                  "Operator"
                )
                (mkButton "q" "<CMD>qa<CR>" "💣 Quit Neovim" "String")
              ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "GruvboxBlue";
              position = "center";
            };
            type = "text";
            val = "https://github.com/sukhmancs/nixos-configs";
          }
        ];
      };

      # colorizer - Colorizer
      nvim-colorizer = {
        enable = true;
      };

      # Comment
      comment = {
        enable = true;
      };

      # flash - Jump to characters
      flash = {
        enable = true;
        labels = "asdfghjklqwertyuiopzxcvbnm";
        search = {
          mode = "fuzzy";
        };
        jump = {
          autojump = true;
        };
        label = {
          uppercase = false;
          rainbow = {
            enabled = false;
            shade = 5;
          };
        };
      };

      # harpoon - Jump to files
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymapsSilent = true;
        keymaps = {
          addFile = "<leader>ha";
          toggleQuickMenu = "<C-e>";
          navFile = {
            "1" = "<leader>hj";
            "2" = "<leader>hk";
            "3" = "<leader>hl";
            "4" = "<leader>hm";
          };
        };
      };

      # illuminate - Highlight word under cursor
      illuminate = {
        enable = true;
        underCursor = false;
        filetypesDenylist = [
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "reason"
        ];
      };

      # mini - AI completion
      mini = {
        enable = true;
        modules = {
          ai = { };
          surround = { };
        };
      };

      # nvim-autopairs - Auto pairs
      nvim-autopairs = {
        enable = true;
      };

      # oil
      oil = {
        enable = true;
        settings = {
          useDefaultKeymaps = true;
          deleteToTrash = true;
          float = {
            padding = 2;
            maxWidth = 0; # ''math.ceil(vim.o.lines * 0.8 - 4)'';
            maxHeight = 0; # ''math.ceil(vim.o.columns * 0.8)'';
            border = "rounded"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            winOptions = {
              winblend = 0;
            };
          };
          preview = {
            border = "rounded";
          };
          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-\\>" = "actions.select_vsplit";
            "<C-enter>" = "actions.select_split"; # this is used to navigate left
            "<C-t>" = "actions.select_tab";
            "<C-v>" = "actions.preview";
            "<C-c>" = "actions.close";
            "<C-r>" = "actions.refresh";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "gs" = "actions.change_sort";
            "gx" = "actions.open_external";
            "g." = "actions.toggle_hidden";
            "q" = "actions.close";
          };
        };
      };

      # ufo - UFO completion
      nvim-ufo = {
        enable = true;
      };

      # which-key - Keybindings
      which-key = {
        enable = true;
      };
    };
  };
}