return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx", "svelte", "scss", "vue" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      local eslint_opts_code_actions = {
        command = "eslint_d",
        args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
        debounce = 100,
        stdin = true,
        -- In order to use the locally installed eslint_d
        cwd = vim.loop.cwd,
      }
      local eslint_opts_diagnostics = {
        command = "eslint_d",
        args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
        debounce = 100,
        stdin = true,
        -- In order to use the locally installed eslint_d
        cwd = vim.loop.cwd,
      }
      table.insert(opts.sources, require "typescript.extensions.null-ls.code-actions")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
      table.insert(opts.sources, nls.builtins.code_actions.eslint_d.with(eslint_opts_code_actions))
      table.insert(opts.sources, nls.builtins.diagnostics.eslint_d.with(eslint_opts_diagnostics))
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "js-debug-adapter" }) -- TODO: To configure debugging
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        tsserver = {},
        tailwindcss = {},
      },
      setup = {
        tsserver = function(_, opts)
          local lsp_utils = require "plugins.lsp.utils"
          lsp_utils.on_attach(function(client, buffer)
            if client.name == "tsserver" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
              vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
            end
          end)
          require("typescript").setup { server = opts }
          return true
        end,
      },
    },
  },
}
