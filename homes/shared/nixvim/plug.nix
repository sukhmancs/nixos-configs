{pkgs, osConfig, ...}:
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
    };
  };
}