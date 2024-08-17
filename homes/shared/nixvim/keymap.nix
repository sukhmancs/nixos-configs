{
  programs.nixvim = {
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>gh";
        action = "gitsigns";
        options = {
          silent = true;
          desc = "+hunks";
        };
      }
      {
        mode = "n";
        key = "<leader>ghb";
        action = ":Gitsigns blame_line<CR>";
        options = {
          silent = true;
          desc = "Blame line";
        };
      }
      {
        mode = "n";
        key = "<leader>ghd";
        action = ":Gitsigns diffthis<CR>";
        options = {
          silent = true;
          desc = "Diff This";
        };
      }
      {
        mode = "n";
        key = "<leader>ghR";
        action = ":Gitsigns reset_buffer<CR>";
        options = {
          silent = true;
          desc = "Reset Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>ghS";
        action = ":Gitsigns stage_buffer<CR>";
        options = {
          silent = true;
          desc = "Stage Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }

      # lspsaga
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Lspsaga finder def<CR>";
        options = {
          desc = "Goto Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Lspsaga finder ref<CR>";
        options = {
          desc = "Goto References";
          silent = true;
        };
      }

      # {
      #   mode = "n";
      #   key = "gD";
      #   action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      #   options = {
      #     desc = "Goto Declaration";
      #     silent = true;
      #   };
      # }

      {
        mode = "n";
        key = "gI";
        action = "<cmd>Lspsaga finder imp<CR>";
        options = {
          desc = "Goto Implementation";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "gT";
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        options = {
          desc = "Type Definition";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<CR>";
        options = {
          desc = "Hover";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>cw";
        action = "<cmd>Lspsaga outline<CR>";
        options = {
          desc = "Outline";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename<CR>";
        options = {
          desc = "Rename";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "Code Action";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        options = {
          desc = "Line Diagnostics";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "[d";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        options = {
          desc = "Next Diagnostic";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "]d";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        options = {
          desc = "Previous Diagnostic";
          silent = true;
        };
      }

      # none-ls
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }

      # telescope
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>Telescope diagnostics bufnr=0<cr>";
        options = {
          desc = "Document diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Telescope file_browser<cr>";
        options = {
          desc = "File browser";
        };
      }
      {
        mode = "n";
        key = "<leader>fE";
        action = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>";
        options = {
          desc = "File browser";
        };
      }
    ];
  };
}