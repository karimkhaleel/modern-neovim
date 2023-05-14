return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--suggest-missing-includes" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function(fname)
            return vim.loop.cwd()
          end,
          init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
          },
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
      },
      setup = {
        clangd = function(_, _)
          local lsp_utils = require "plugins.lsp.utils"
          lsp_utils.on_attach(function(client, buffer) end)
        end,
      },
    },
  },
}
