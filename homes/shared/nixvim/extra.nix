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
  '';
}