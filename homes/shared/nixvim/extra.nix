{
  programs.nixvim.extraConfigLua = ''
    require("telescope").load_extension("lazygit")

    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }

    require("staline").setup({
      sections = {
        left = { "-mode", " ", "branch" },
        mid = { "lsp_name" },
        right = { "file_name", "line_column" },
      },
      inactive_sections = {
        left = { "-mode", " ", "branch" },
        mid = { "lsp_name" },
        right = { "file_name", "line_column" },
      },
      defaults = {
        left_separator = " ",
        right_separator = "  ",
        branch_symbol = " ",
        mod_symbol = "",
        line_column = "[%l/%L]",
        inactive_color = "#80a6f2", --#303030 is the default
        inactive_bgcolor = "none",
      },
      special_table = {
        lazy = { "Plugins", "💤 " },
        TelescopePrompt = { "Telescope", "  " },
        oil = { "Oil", "󰏇 " },
        lazygit = { "LazyGit", " " },
      },
      mode_icons = {
        ["n"] = "NORMAL",
        ["no"] = "NORMAL",
        ["nov"] = "NORMAL",
        ["noV"] = "NORMAL",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["s"] = "INSERT",
        ["S"] = "INSERT",
        ["v"] = "VISUAL",
        ["V"] = "VISUAL",
        [""] = "VISUAL",
        ["r"] = "REPLACE",
        ["r?"] = "REPLACE",
        ["R"] = "REPLACE",
        ["c"] = "COMMAND",
        ["t"] = "TERMINAL",
      },
    })

    require("telescope").setup{
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    }

    require('precognition').setup({ })

    local notify = require("notify")

    local filtered_message = { "No information available" }

    -- Override notify function to filter out messages
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(message, level, opts)
      local merged_opts = vim.tbl_extend("force", {
        on_open = function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
        end,
      }, opts or {})

      for _, msg in ipairs(filtered_message) do
        if message == msg then
          return
        end
      end
      return notify(message, level, merged_opts)
    end

    require('btw').setup({
      text = "I use Neovim (and NixOS, BTW)",
    })

    function ToggleLineNumber()
    if vim.wo.number then
      vim.wo.number = false
    else
      vim.wo.number = true
        vim.wo.relativenumber = false
        end
        end

        function ToggleRelativeLineNumber()
        if vim.wo.relativenumber then
          vim.wo.relativenumber = false
        else
          vim.wo.relativenumber = true
            vim.wo.number = false
            end
            end

            function ToggleWrap()
            vim.wo.wrap = not vim.wo.wrap
            end
  '';
}