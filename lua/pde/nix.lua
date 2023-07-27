if not require("config").pde.nix then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "nix" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          settings = {
            formatting = {
              command = "nixpkgs-fmt",
            },
          },
        },
      },
    },
    setup = {
      nil_ls = function(_, opts)
        require("plugins.lsp.utils").on_attach(function(client, bufnr)
          print("blabla")
          if client.name == "nil" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>", { buffer = bufnr, desc = "Organize Imports" })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>lR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = bufnr })
          end
        end)
        return true
      end,
    },
  },
}
