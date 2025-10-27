{ config, pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      # Use blink.cmp capabilities - FIXED TYPO
      capabilities = "require('blink.cmp').get_lsp_capabilities()";

      servers = {
        ts_ls.enable = true;

        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };

        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };

        nil_ls.enable = true;
        pyright.enable = true;
        bashls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;

        # Add Hyprland configuration language server
        hyprls = {
          enable = true;
        };
      };
    };

    extraConfigLua = ''
      -- Set up LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local keymap = vim.keymap
          local opts = { buffer = ev.buf, silent = true }

          -- Set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "Show LSP definition"
          keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", function()
            vim.diagnostic.goto_prev({ float = true })
          end, opts)

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", function()
            vim.diagnostic.goto_next({ float = true })
          end, opts)

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts)

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

          -- Format on save for supported filetypes
          if ev.data and ev.data.client_id then
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client.supports_method("textDocument/formatting") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormatting", {}),
                buffer = ev.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = ev.buf })
                end,
              })
            end
          end
        end,
      })

      -- Configure diagnostic signs
      local severity = vim.diagnostic.severity
      vim.diagnostic.config({
        signs = {
          text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
          },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    '';
  };
}
